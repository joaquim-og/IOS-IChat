//
//  SplashViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 21/03/24.
//

import Foundation
import FirebaseAuth
import Combine

class ContentViewViewModel:  ObservableObject {
        
    @Published var uiState: ContentViewUiState = .none
    
    func checkIfuserIsLogged() {
        setLoadingState()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if (user != nil) {
                self.setUserStateState(userState: .logged)
            } else {
                self.setUserStateState(userState: .unLogged)
            }
        }
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setUserStateState(userState: ContentViewUiState) {
        DispatchQueue.main.async {
            self.uiState = userState
        }
    }
    
    private func setErrorState(error: String) {
        DispatchQueue.main.async {
            self.uiState = .error(error)
        }
    }
    
    
}
