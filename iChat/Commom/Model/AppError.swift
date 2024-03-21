//
//  AppError.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 21/03/24.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
