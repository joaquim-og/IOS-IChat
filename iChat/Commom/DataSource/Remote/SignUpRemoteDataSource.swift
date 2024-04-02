//
//  SignUpRemoteDataSource.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 21/03/24.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignUpRemoteDataSource {
    
    static var signUpRemoteDataSourceShared = SignUpRemoteDataSource()
    
    private let genericServerErrorMessage = NSLocalizedString("generic_server_error", comment: "")
    
    func signUp(
        request: SignUpRequest
    ) -> Future<User, AppError> {
        return Future { promise in
            Auth.auth().createUser(
                withEmail: request.email,
                password: request.password,
                completion: { result, error in
                    if let errorMessage = error {
                        promise(.failure(AppError.response(message: self.genericServerErrorMessage)))
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
    
    func createUserPhoto(
        userPhoto: Data
    ) -> Future<URL, AppError> {
        return Future { promise in
            let newMetadata = StorageMetadata()
            newMetadata.contentType = "image/jpeg"
            
            let fileName = UUID().uuidString
            
            let ref = Storage.storage().reference(withPath: "/images/\(fileName).jpg")
            
            ref.putData(
                userPhoto,
                metadata: newMetadata,
                completion: { metadata, errorMessage in
                    if let errorMessage {
                        promise(.failure(AppError.response(message: errorMessage.localizedDescription)))
                        return
                    }
                    ref.downloadURL { url, publicUrlError in
                        if let publicUrlError {
                            promise(.failure(AppError.response(message: publicUrlError.localizedDescription)))
                            return
                        }
                        guard let url = url else {
                            promise(.failure(AppError.response(message: publicUrlError?.localizedDescription ?? self.genericServerErrorMessage)))
                            return
                        }
                        promise(.success(url))
                    }
                }
            )
        }
    }
    
    func createUser(
        userName: String,
        photoUrl: URL
    ) -> Future<Bool, AppError> {
        return Future { promise in
            let userId = Auth.auth().currentUser!.uid
            Firestore.firestore()
                .collection(NSLocalizedString("firedtore_db_references_user", comment: ""))
                .document(userId)
                .setData([
                    "name": userName,
                    "uuid": userId,
                    "profileUrl": photoUrl.absoluteString
                ]) { error in
                    if (error != nil) {
                        promise(.failure(AppError.response(message: error?.localizedDescription ?? self.genericServerErrorMessage)))
                        return
                    } else {
                        promise(.success(true))
                    }
                }
        }
    }
}
