//
//  MessagesViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import Foundation
import FirebaseAuth
import Combine

class MessagesViewModel:  ObservableObject {
    
    
    private let messagesInteractor = MessagesInteractor()
    private var requestMessagesCancellable: AnyCancellable?

    @Published var uiState: MessagesUiState = .none
    
    deinit {
        requestMessagesCancellable?.cancel()
    }
    
    func doLogout() {
        try? Auth.auth().signOut()
    }
    
    func checkIfuserIsLogged() {
        setLoadingState()
        
//        requestUserLoggedCancellable = signInRemoteDataSource.getCurrentUser()
//        .receive(on: DispatchQueue.main)
//        .sink { onComplete in
//            switch (onComplete) {
//            case .failure(let appError):
//                self.setErrorState(error: appError.message)
//                break
//            case .finished:
//                break
//            }
//        } receiveValue: { user in
//            if (user != nil) {
//                self.setUserStateState(userState: .logged)
//            } else {
//                self.setUserStateState(userState: .unLogged)
//            }
//        }
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setUserStateState(userState: MessagesUiState) {
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
