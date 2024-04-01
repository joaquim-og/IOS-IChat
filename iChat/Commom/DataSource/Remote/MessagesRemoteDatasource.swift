//
//  MessagesRemoteDatasource.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class MessagesRemoteDataSource {
    
    static var messagesRemoteDataSourceShared = MessagesRemoteDataSource()
    
    private let genericServerErrorMessage = NSLocalizedString("generic_server_error", comment: "")
    private let lastMessagesIdentifier = NSLocalizedString("generic_last_messages_identifier", comment: "")
    private let contactsIdentifier = NSLocalizedString("generic_contacts_identifier", comment: "")
    
    func getContacts() -> Future<[Contact], AppError> {
        return Future { promise in
            
            let fromId = Auth.auth().currentUser!.uid
            
            Firestore.firestore().collection(self.lastMessagesIdentifier)
                .document(fromId)
                .collection(self.contactsIdentifier)
                .addSnapshotListener { querySnapshot, error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                    
                    if let docChanges = querySnapshot?.documentChanges {
                        
                        var userContacts: [Contact] = []
                        
                        docChanges.forEach { doc in
                            
                            if (doc.type == .added){
                                
                                let document = doc.document
                                
                                let contact = Contact(
                                    uuid: document.documentID,
                                    name: document.data()["username"] as! String,
                                    profileUrl: document.data()["photoUrl"] as! String,
                                    lastMessage: document.data()["lastMessage"] as! String,
                                    timeStamp: document.data()["timeStamp"] as! UInt
                                )
                                
                                userContacts.append(contact)
                            }
                        }
                        
                        promise(.success(userContacts))
                    }
                }
        }
    }
    

}
