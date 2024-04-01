//
//  ChatUiState.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 28/03/24.
//

import Foundation

enum ChatUiState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
