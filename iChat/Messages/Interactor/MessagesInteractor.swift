//
//  MessagesInteractor.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import Foundation
import Combine
import SwiftUI

class MessagesInteractor {
    private let remoteDataSource: MessagesRemoteDataSource = MessagesRemoteDataSource.messagesRemoteDataSourceShared
}

extension MessagesInteractor {
    
    func getContacts() -> Future<[Contact], AppError> {
        return remoteDataSource.getContacts()
    }
    
}
