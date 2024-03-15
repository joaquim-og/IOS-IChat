//
//  SIgnUpViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUiState = .none
    
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var image = UIImage()
    
    func signUp() {
        setLoadingState()
        
        if (image.size.width <= 0) {
            setErrorState(error: NSLocalizedString("sign_up_error_no_photo", comment: ""))
            return
        }
        
        Auth.auth().createUser(
            withEmail: email,
            password: password,
            completion: { result, error in
                guard let user = result?.user, error == nil else {
                    self.setErrorState(error: error?.localizedDescription ?? "")
                    return
                }
                
                self.uploadUserPhoto()
            }
        )
    }
    
    private func uploadUserPhoto() {
        
        let fileName = UUID().uuidString
        
        let ref = Storage.storage().reference(withPath: "/images/\(fileName).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        ref.putData(
            data,
            metadata: newMetadata,
            completion: { metadata, error in
                if (error != nil) {
                    self.setErrorState(error: error?.localizedDescription ?? "")
                    return
                }
                ref.downloadURL { url, publicUrlError in
                    if (publicUrlError != nil) {
                        self.setErrorState(error: publicUrlError?.localizedDescription ?? "")
                        return
                    }
                    guard let url = url else {
                        self.setErrorState(error: publicUrlError?.localizedDescription ?? "")
                        return
                    }
                    self.createUser(photoUrl: url)
                }
            }
        )
    }
    
    private func createUser(photoUrl: URL) {
        Firestore.firestore()
            .collection(NSLocalizedString("firedtore_db_references_user", comment: ""))
            .document()
            .setData([
                "name": name,
                "uuid": Auth.auth().currentUser!.uid,
                "profileUrl": photoUrl.absoluteString
            ]) { error in
                if (error != nil) {
                    self.setErrorState(error: error?.localizedDescription ?? "")
                    return
                } else {
                    self.setSuccessState()
                    //navigate to home
                }
            }
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setSuccessState() {
        DispatchQueue.main.async {
            self.uiState = .success
        }
    }
    
    private func setErrorState(error: String) {
        DispatchQueue.main.async {
            self.uiState = .error(error)
        }
    }
    
}
