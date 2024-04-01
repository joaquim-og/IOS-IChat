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
    private let contactsRemoteDataSource: ContactsRemoteDataSource = ContactsRemoteDataSource.contactsRemoteDataSourceShared
}

extension ChatInteractor {
    
    func getMessages(toId: String) -> Future<[Message], AppError>  {
        return remoteDataSource.getMessages(toId: toId)
    }
    
    func sendMessage(contact: Contact, textToSend: String, myName: String, myPhoto: String) -> Future<Void, AppError>  {
        return remoteDataSource.sendMessage(contact: contact, textToSend: textToSend, myName: myName, myPhoto: myPhoto)
    }
    
    func getMySelf() -> Future<Contact, AppError>  {
        return contactsRemoteDataSource.getMySelf()
    }
    
}
