//
//  SIgnInViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    
    @Published var uiState: SignInUiState = .none
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        setLoadingState()
        debugPrint("Xablau email -> \(email)")
        debugPrint("Xablau password -> \(password)")
        
        Auth.auth().signIn(
            withEmail: email,
            password: password,
            completion: { result, error in
                guard let user = result?.user, error == nil else {
                    self.setErrorState(error: error?.localizedDescription ?? "")
                    debugPrint("Xablau erro do user -> \(error)")
                    return
                }
                
                self.setSuccessState()
                debugPrint("Xablau user logado -> \(user.uid)")
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
