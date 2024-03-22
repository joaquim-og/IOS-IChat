//
//  SignInRemoteDataSource.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 21/03/24.
//

import Foundation
import Combine
import FirebaseAuth

class SignInRemoteDataSource {
    
    static var signInRemoteDataSourceShared = SignInRemoteDataSource()
        
    func signIn(
        request: SignInRequest
    ) -> Future<User, AppError> {
        return Future { promise in
            
            Auth.auth().signIn(
                withEmail: request.email,
                password: request.password,
                completion: { result, error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                    
                    if let user = result?.user {
                        promise(.success(user))
                        return
                    }
                }
            )
        }
    }
    
    func getCurrentUser() -> Future<User?, AppError> {
        return Future { promise in
            let currentuser = Auth.auth().currentUser
            
            promise(.success(currentuser))
        }
    }
}
