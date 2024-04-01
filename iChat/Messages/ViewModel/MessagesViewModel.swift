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
    private var getMessagesCancellable: AnyCancellable?

    @Published var uiState: MessagesUiState = .none
    @Published var contacts: [Contact] = []
    
    deinit {
        getMessagesCancellable?.cancel()
    }
    
    func doLogout() {
        try? Auth.auth().signOut()
    }
    
    func getContacts() {
        setLoadingState()
        
        getMessagesCancellable = messagesInteractor.getContacts()
        .receive(on: DispatchQueue.main)
        .sink { onComplete in
            switch (onComplete) {
            case .failure(let appError):
                self.setErrorState(error: appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { contacts in
            self.contacts = contacts
            self.seMessagestateState(messagesState: .success)
        }
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func seMessagestateState(messagesState: MessagesUiState) {
        DispatchQueue.main.async {
            self.uiState = messagesState
        }
    }
    
    private func setErrorState(error: String) {
        DispatchQueue.main.async {
            self.uiState = .error(error)
        }
    }
    
    
}
