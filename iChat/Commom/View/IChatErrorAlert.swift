//
//  IChatErrorAlert.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import SwiftUI

struct IChatErrorAlert: View {
    let error: String
    
    var body: some View {
        Text("").alert(isPresented: .constant(true)) {
            Alert(title: Text(
                NSLocalizedString("generic_app_name", comment: "")),
                  message: Text(error),
                  dismissButton: .default(Text(NSLocalizedString("generic_confirmation_text", comment: ""))))
        }
    }
}

struct IChatErrorAlertPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            IChatErrorAlert(error: "XAblau error")
                .preferredColorScheme(colorScheme)
        }
    }
}
