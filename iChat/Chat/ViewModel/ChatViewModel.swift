//
//  ChatViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 28/03/24.
//

import Foundation
import Combine

class ChatViewModel:  ObservableObject {

    private let chatInteractor = ChatInteractor()
    private var sendChatTextCancellable: AnyCancellable?
    private var getChatTextCancellable: AnyCancellable?
    private var getMySelfCancellable: AnyCancellable?

    @Published var uiState: ChatUiState = .none
    @Published var messages: [Message] = []
    @Published var text: String = ""
    
    var myPhoto = ""
    var myName = ""
    
    deinit {
        sendChatTextCancellable?.cancel()
        getChatTextCancellable?.cancel()
        getMySelfCancellable?.cancel()
    }
    
    func onAppear(contact: Contact) {
        setLoadingState()
        getMySelfCancellable = chatInteractor.getMySelf()
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
                self.myPhoto = user.profileUrl
                self.myName = user.name
            }
        
        getChatTextCancellable = chatInteractor.getMessages(toId: contact.uuid)
            .receive(on: DispatchQueue.main)
            .sink { onComplete in
                switch (onComplete) {
                case .failure(let appError):
                    self.setErrorState(error: appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { messageList in
                self.messages = messageList
                self.setChatState(newState: .success)
            }
    }
    
    func sendMessage(contact: Contact) {
        setLoadingState()
        sendChatTextCancellable = chatInteractor.sendMessage(
            contact: contact,
            textToSend: text,
            myName: myName,
            myPhoto: myPhoto
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
                self.onAppear(contact: contact)
            }
    }
    
    private func setLoadingState() {
        DispatchQueue.main.async {
            self.uiState = .loading
        }
    }
    
    private func setChatState(newState: ChatUiState) {
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
