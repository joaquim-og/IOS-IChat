//
//  SignUpInteractor.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 21/03/24.
//

import Foundation
import Combine
import FirebaseAuth
import SwiftUI

class SignUpInteractor {
    private let remoteDataSource: SignUpRemoteDataSource = SignUpRemoteDataSource.signUpRemoteDataSourceShared
}

extension SignUpInteractor {
    
    func signUp(
        request: SignUpRequest
    ) -> Future<User, AppError> {
        return remoteDataSource.signUp(request: request)
    }
    
    func createUserPhoto(
        userPhoto: Data
    ) -> Future<URL, AppError> {
        return remoteDataSource.createUserPhoto(userPhoto: userPhoto)
    }
    
    func createUser(
        userName: String,
        photoUrl: URL
    ) -> Future<Bool, AppError> {
        return remoteDataSource.createUser(
            userName: userName,
            photoUrl: photoUrl
        )
    }
}
