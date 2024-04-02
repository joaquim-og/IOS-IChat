//
//  ChateRemoteDataSource.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 01/04/24.
//
import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class ChatRemoteDataSource {
    
    static var chatRemoteDataSourceShared = ChatRemoteDataSource()
    
    private let genericServerErrorMessage = NSLocalizedString("generic_server_error", comment: "")
    private let conversationsIdentifier = NSLocalizedString("generic_conversations_identifier", comment: "")
    private let lastMessagesIdentifier = NSLocalizedString("generic_last_messages_identifier", comment: "")
    private let contactsIdentifier = NSLocalizedString("generic_contacts_identifier", comment: "")
    
    func getMessages(toId: String) -> Future<[Message], AppError> {
        return Future { promise in
            let fromId = Auth.auth().currentUser!.uid
            
            var userMessages: [Message] = []
            
            Firestore.firestore().collection(self.conversationsIdentifier)
                .document(fromId)
                .collection(toId)
                .order(by: "timeStamp", descending: false)
                .addSnapshotListener { querySnapshot, error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                    
                    if let docChanges = querySnapshot?.documentChanges {
                        
                        userMessages = []
                        
                        docChanges.forEach { doc in
                            let document = doc.document
                            
                            let message = Message(
                                uuid: document.documentID,
                                text: document.data()["text"] as! String,
                                isMe: fromId == document.data()["fromId"] as! String
                            )
                            
                            userMessages.append(message)
                        }
                        
                        promise(.success(userMessages))
                    }
                }
        }
    }
    
    func sendMessage(contact: Contact, textToSend: String, myName: String, myPhoto: String) -> Future<Void, AppError> {
        return Future { promise in
            let fromId = Auth.auth().currentUser!.uid
            let timeStamp = Date().timeIntervalSince1970
            
            Firestore.firestore().collection(self.conversationsIdentifier)
                .document(fromId)
                .collection(contact.uuid)
                .addDocument(data: [
                    "text": textToSend,
                    "fromId": fromId,
                    "toId": contact.uuid,
                    "timeStamp": UInt(timeStamp)
                ]) { error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                }
            
            Firestore.firestore().collection(self.lastMessagesIdentifier)
                .document(fromId)
                .collection(self.contactsIdentifier)
                .document(contact.uuid)
                .setData([
                    "uid": contact.uuid,
                    "username": contact.name,
                    "photoUrl": contact.profileUrl,
                    "timeStamp": UInt(timeStamp),
                    "lastMessage": textToSend
                ]) { error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                }
            
            Firestore.firestore().collection(self.conversationsIdentifier)
                .document(contact.uuid)
                .collection(fromId)
                .addDocument(data: [
                    "text": textToSend,
                    "fromId": fromId,
                    "toId": contact.uuid,
                    "timeStamp": UInt(timeStamp)
                ]) { error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                }
            
            Firestore.firestore().collection(self.lastMessagesIdentifier)
                .document(contact.uuid)
                .collection(self.contactsIdentifier)
                .document(fromId)
                .setData([
                    "uid": fromId,
                    "username": myName,
                    "photoUrl": myPhoto,
                    "timeStamp": UInt(timeStamp),
                    "lastMessage": textToSend
                ]) { error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                }
            
            
            promise(.success(Void()))
            
        }
    }
}
