//
//  SignInUiState.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import Foundation

enum SignInUiState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
