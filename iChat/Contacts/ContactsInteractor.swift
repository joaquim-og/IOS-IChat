//
//  ContactsInteractor.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import Foundation
import Combine

class ContactsInteractor {
    private let remoteDataSource: ContactsRemoteDataSource = ContactsRemoteDataSource.contactsRemoteDataSourceShared
}

extension ContactsInteractor {
    
    func getContacts() -> Future<[Contact], AppError>  {
        return remoteDataSource.getContacts()
    }
    
}
