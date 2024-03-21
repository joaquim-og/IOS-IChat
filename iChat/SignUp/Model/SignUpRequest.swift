//
//  SignUpRequest.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 21/03/24.
//

import Foundation

struct SignUpRequest {
    
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
    }
    
}
