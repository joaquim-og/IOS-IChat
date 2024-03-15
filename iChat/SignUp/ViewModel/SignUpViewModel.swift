//
//  SIgnUpViewModel.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var name = ""
    @Published var password = ""
    
    func signUp() {
        debugPrint("Xablau email -> \(email)")
        debugPrint("Xablau name -> \(name)")
        debugPrint("Xablau password -> \(password)")
    }
    
}
