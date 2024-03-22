//
//  MessagesRemoteDatasource.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseFirestore

class MessagesRemoteDataSource {
    
    static var messagesRemoteDataSourceShared = MessagesRemoteDataSource()
    
    private let genericServerErrorMessage = NSLocalizedString("generic_server_error", comment: "")
    
//    func signUp(
//        request: SignUpRequest
//    ) -> Future<User, AppError> {
//        return Future { promise in
//            Auth.auth().createUser(
//                withEmail: request.email,
//                password: request.password,
//                completion: { result, error in
//                    if let errorMessage = error {
//                        promise(.failure(AppError.response(message: self.genericServerErrorMessage)))
//                        return
//                    }
//                    
//                    if let user = result?.user {
//                        promise(.success(user))
//                        return
//                    }
//                }
//            )
//        }
//    }
    

}
