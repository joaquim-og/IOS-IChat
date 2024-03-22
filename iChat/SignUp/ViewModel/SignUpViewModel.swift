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
import Combine

class SignUpViewModel: ObservableObject {
    
    private let genericServerErrorMessage = NSLocalizedString("generic_server_error", comment: "")
    
    private let signUpInteractor = SignUpInteractor()
    private var requestSignUpCancellable: AnyCancellable?
    private var requestUploadPhotoCancellable: AnyCancellable?
    private var requestCreateuserCancellable: AnyCancellable?
    
    @Published var uiState: SignUpUiState = .none
    
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    @Published var image = UIImage()
    
    deinit {
        requestSignUpCancellable?.cancel()
        requestUploadPhotoCancellable?.cancel()
        requestCreateuserCancellable?.cancel()
    }
    
    func signUp() {
        setLoadingState()
        
        if (image.size.width <= 0) {
            setErrorState(error: NSLocalizedString("sign_up_error_no_photo", comment: ""))
            return
        }
        
        let request = SignUpRequest(
            email: email, 
            password: password
        )
        
        requestSignUpCancellable = signUpInteractor.signUp(
            request: request
        )
        .receive(on: DispatchQueue.main)
        .sink { onComplete in
            switch (onComplete) {
            case .failure(let appError):
                self.setErrorState(error: appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { _ in
            self.uploadUserPhoto()
        }
    }
    
    private func uploadUserPhoto() {
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        
        requestUploadPhotoCancellable = signUpInteractor.createUserPhoto(
            userPhoto: data
        )
        .receive(on: DispatchQueue.main)
        .sink { onComplete in
            switch (onComplete) {
            case .failure(let appError):
                self.setErrorState(error: appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { url in
            self.createUser(photoUrl: url)
        }
    }
    
    private func createUser(
        photoUrl: URL
    ) {
        
        requestCreateuserCancellable = signUpInteractor.createUser(
            userName: name,
            photoUrl: photoUrl
        )
        .receive(on: DispatchQueue.main)
        .sink { onComplete in
            switch (onComplete) {
            case .failure(let appError):
                self.setErrorState(error: appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { url in
            self.setSuccessState()
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
