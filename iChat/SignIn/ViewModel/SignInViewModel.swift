//
//  SIgnInViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import Foundation
import FirebaseAuth
import Combine

class SignInViewModel: ObservableObject {
    
    private let genericServerErrorMessage = NSLocalizedString("generic_server_error", comment: "")
    
    private let signInRemoteDataSource = SignInRemoteDataSource.signInRemoteDataSourceShared
    private var requestSignInCancellable: AnyCancellable?
    
    @Published var uiState: SignInUiState = .none
    
    @Published var email = ""
    @Published var password = ""
    
    deinit {
        requestSignInCancellable?.cancel()
    }
    
    func signIn() {
        setLoadingState()
        
        let request = SignInRequest(
            email: email, 
            password: password
        )
        
        requestSignInCancellable = signInRemoteDataSource.signIn(
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
        } receiveValue: { user in
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
