//
//  SIgnInViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() {
        debugPrint("Xablau email -> \(email)")
        debugPrint("Xablau password -> \(password)")
    }
    
}
