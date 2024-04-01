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

    @Published var uiState: ChatUiState = .none
    @Published var messages: [Message] = []
    @Published var text: String = ""
    
    
    deinit {
        sendChatTextCancellable?.cancel()
        getChatTextCancellable?.cancel()
    }
    
    func onAppear(toId: String) {
        setLoadingState()
        getChatTextCancellable = chatInteractor.getMessages(toId: toId)
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
    
    func sendMessage(toId: String) {
        setLoadingState()
        sendChatTextCancellable = chatInteractor.sendMessage(toId: toId, textToSend: text)
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
                self.onAppear(toId: toId)
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
