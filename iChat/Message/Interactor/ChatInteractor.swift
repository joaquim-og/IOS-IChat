//
//  ChatInteractor.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 01/04/24.
//

import Foundation
import Combine

class ChatInteractor {
    private let remoteDataSource: ChatRemoteDataSource = ChatRemoteDataSource.chatRemoteDataSourceShared
}

extension ChatInteractor {
    
    func getMessages(toId: String) -> Future<[Message], AppError>  {
        return remoteDataSource.getMessages(toId: toId)
    }
    
    func sendMessage(toId: String, textToSend: String) -> Future<Void, AppError>  {
        return remoteDataSource.sendMessage(toId: toId, textToSend: textToSend)
    }
    
}
