//
//  ChatViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 28/03/24.
//

import Foundation
import Combine

class ChatViewModel:  ObservableObject {
    

    @Published var uiState: ChatUiState = .none
    @Published var messages: [Message] = [
        Message(uuid: UUID().uuidString, text: "message 1", isMe: false),
        Message(uuid: UUID().uuidString, text: "message 2", isMe: false),
        Message(uuid: UUID().uuidString, text: "message 3", isMe: true),
        Message(uuid: UUID().uuidString, text: "message 4", isMe: false),
        Message(uuid: UUID().uuidString, text: "message 5", isMe: false),
        Message(uuid: UUID().uuidString, text: "message 6", isMe: true),
        Message(uuid: UUID().uuidString, text: "message 7", isMe: true),
        Message(uuid: UUID().uuidString, text: "message 1", isMe: false)
    ]
    @Published var text: String = ""
    
    func getContacts() {
        setLoadingState()
        
//        requestContactsCancellable = contactsInteractor.getContacts()
//        .receive(on: DispatchQueue.main)
//        .sink { onComplete in
//            switch (onComplete) {
//            case .failure(let appError):
//                self.setErrorState(error: appError.message)
//                break
//            case .finished:
//                break
//            }
//        } receiveValue: { contactsList in
//            self.setContactState(newState: .success)
//            self.contacts = contactsList
//        }
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setContactState(newState: ChatUiState) {
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
