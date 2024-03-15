//
//  SIgnUpViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    
    @Published var uiState: SignUpUiState = .none
    
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    
    func signUp() {
        setLoadingState()
        debugPrint("Xablau email -> \(email)")
        debugPrint("Xablau name -> \(name)")
        debugPrint("Xablau password -> \(password)")
        
        Auth.auth().createUser(
            withEmail: email,
            password: password,
            completion: { result, error in
                guard let user = result?.user, error == nil else {
                    self.setErrorState(error: error?.localizedDescription ?? "")
                    debugPrint("Xablau erro do user -> \(error)")
                    return
                }
                
                self.setSuccessState()
                debugPrint("Xablau user criado -> \(user.uid)")
            }
        )
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
