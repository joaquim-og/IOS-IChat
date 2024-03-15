//
//  IChatSecureEditTextView.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import SwiftUI

struct IChatSecureEditTextView: View {
    
    @Binding var text: String
    var placeHolder: String = ""
    var error: String? = nil
    var failure: Bool? = nil
    
    var body: some View {
        VStack{
            SecureField(
                placeHolder,
                text: $text
            )
            .padding()
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .background(Color.white)
            .cornerRadius(24.0)
            .overlay(
                RoundedRectangle(cornerRadius: 24.0)
                    .stroke(
                        Color(UIColor.separator), lineWidth: 1
                    )
            )
            
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
    }
}

struct IChatSecureEditTextViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            IChatSecureEditTextView(
                text: .constant(""),
                placeHolder: NSLocalizedString("generic_password_placeholder", comment: ""),
                error: NSLocalizedString("generic_password_error_message", comment: "")
            )
            .preferredColorScheme(colorScheme)
        }
    }
}
