//
//  ContactsRemoteDataSource.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//


import Foundation
import Combine
import FirebaseFirestore

class ContactsRemoteDataSource {
    
    static var contactsRemoteDataSourceShared = ContactsRemoteDataSource()
    
    private let genericServerErrorMessage = NSLocalizedString("generic_server_error", comment: "")
    
    func getContacts() -> Future<[Contact], AppError> {
        return Future { promise in
            Firestore.firestore().collection("users")
                .getDocuments { querySnapshot, error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                    
                    var contactsList: [Contact] = []
                    querySnapshot!.documents.forEach { document in
                        contactsList.append(
                            Contact(
                                uuid: document.documentID,
                                name: document.data()["name"] as! String,
                                profileUrl: document.data()["profileUrl"] as! String
                            )
                        )
                    }
                    
                    promise(.success(contactsList))
                }
        }
    }
}
