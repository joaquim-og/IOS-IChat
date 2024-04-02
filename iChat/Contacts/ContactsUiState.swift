//
//  ContactsUiState.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import Foundation

enum ContactsUiState: Equatable {
    case none
    case loading
    case success
    case error(String)
}
