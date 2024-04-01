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
    
    func sendMessage(toId: String, textToSend: String) -> Future<Void, AppError> {
        return Future { promise in
            let fromId = Auth.auth().currentUser!.uid
            let timeStamp = Date().timeIntervalSince1970
            
            Firestore.firestore().collection(self.conversationsIdentifier)
                .document(fromId)
                .collection(toId)
                .addDocument(data: [
                    "text": textToSend,
                    "fromId": fromId,
                    "toId": toId,
                    "timeStamp": UInt(timeStamp)
                ]) { error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                }
            
            Firestore.firestore().collection(self.conversationsIdentifier)
                .document(toId)
                .collection(fromId)
                .addDocument(data: [
                    "text": textToSend,
                    "fromId": fromId,
                    "toId": toId,
                    "timeStamp": UInt(timeStamp)
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
