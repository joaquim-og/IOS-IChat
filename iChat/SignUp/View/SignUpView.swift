//
//  ContentView.swift
//  iChat
//
//  Created by Joaquim Gomes on 15/03/24.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            IChatLogo()
            nameField
            emailField
            passwordField
            signInButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 22)
        .background(
            Color.init(
                red: 240 / 255,
                green: 231 / 255,
                blue: 210 / 255
            )
        )
    }
}

extension SignUpView {
    var nameField: some View {
        IChatTextFieldView(
            text: $viewModel.name,
            placeHolder: NSLocalizedString("generic_name_placeholder", comment: ""),
            error: ""
        )
    }
}


extension SignUpView {
    var emailField: some View {
        IChatTextFieldView(
            text: $viewModel.email,
            placeHolder: NSLocalizedString("generic_email_placeholder", comment: ""),
            error: NSLocalizedString("generic_email_error_message", comment: "")
        )
        .padding(.bottom, 15)
        .padding(.top, 20)
    }
}

extension SignUpView {
    var passwordField: some View {
        IChatSecureEditTextView(
            text: $viewModel.password,
            placeHolder: NSLocalizedString("generic_password_placeholder", comment: ""),
            error: NSLocalizedString("generic_password_error_message", comment: "")
        )
    
        .padding(.bottom, 20)
    }
}

extension SignUpView {
    var signInButton: some View {
        IChatLoadingButtonView(
            action: {
                viewModel.signUp()
            },
            buttonText: NSLocalizedString("sign_up_view_button_enter", comment: ""),
            showProgress: false,
            disabled: false)
    }
}

struct SignUpViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            SignUpView()
                .preferredColorScheme(colorScheme)
        }
    }
}
