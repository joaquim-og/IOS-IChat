//
//  ContactsViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import Foundation
import Combine

class ContactsViewModel:  ObservableObject {
    
    
    private let contactsInteractor = ContactsInteractor()
    private var requestContactsCancellable: AnyCancellable?

    @Published var uiState: ContactsUiState = .none
    @Published var contacts: [Contact] = []
    
    deinit {
        requestContactsCancellable?.cancel()
    }
    
    
    func getContacts() {
        setLoadingState()
        
        requestContactsCancellable = contactsInteractor.getContacts()
        .receive(on: DispatchQueue.main)
        .sink { onComplete in
            switch (onComplete) {
            case .failure(let appError):
                self.setErrorState(error: appError.message)
                break
            case .finished:
                break
            }
        } receiveValue: { contactsList in
            self.setContactState(newState: .success)
            self.contacts = contactsList
        }
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setContactState(newState: ContactsUiState) {
        DispatchQueue.main.async {
            self.uiState = newState
        }
    }
    
    private func setErrorState(error: String) {
        DispatchQueue.main.async {
            self.uiState = .error(error)
        }
    }
    
    
}
