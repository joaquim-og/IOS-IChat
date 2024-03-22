//
//  IChatTextField.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import SwiftUI

struct IChatTextFieldView: View {
    
    @Binding var text: String
    var placeHolder: String = ""
    var error: String? = nil
    var failure: Bool? = nil
    var keyboard: UIKeyboardType = .default
    var autocapitalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack{
            TextField(
                placeHolder,
                text: $text
            )
            .keyboardType(keyboard)
            .autocapitalization(autocapitalization)
            .disableAutocorrection(true)
            .padding()
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
        .padding(.bottom, 10)
    }
}

struct IChatTextFieldPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            IChatTextFieldView(
                text: .constant("XABLAUEIXON"),
                placeHolder: NSLocalizedString("generic_email_placeholder", comment: ""),
                error: NSLocalizedString("generic_email_error_message", comment: "")
            )
            .preferredColorScheme(colorScheme)
        }
    }
}
