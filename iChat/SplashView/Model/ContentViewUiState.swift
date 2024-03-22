//
//  SplashUiState.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 21/03/24.
//

import Foundation

enum ContentViewUiState: Equatable {
    case none
    case loading
    case logged
    case unLogged
    case error(String)
}
