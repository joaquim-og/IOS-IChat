//
//  ContentView.swift
//  iChat
//
//  Created by Joaquim Gomes on 15/03/24.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        VStack {
            IChatLogo()
            emailField
            passwordField
            signInButton
            Divider()
                .padding()
            signUpButton
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

extension SignInView {
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

extension SignInView {
    var passwordField: some View {
        IChatSecureEditTextView(
            text: $viewModel.password,
            placeHolder: NSLocalizedString("generic_password_placeholder", comment: ""),
            error: NSLocalizedString("generic_password_error_message", comment: "")
        )
    
        .padding(.bottom, 20)
    }
}

extension SignInView {
    var signInButton: some View {
        IChatLoadingButtonView(
            action: {
                viewModel.signIn()
            },
            buttonText: NSLocalizedString("sign_in_view_button_enter", comment: ""),
            showProgress: false,
            disabled: false)
    }
}

extension SignInView {
    var signUpButton: some View {
        Button(
            action: {},
            label: {
                Text(
                    NSLocalizedString(
                        "sign_in_view_button_sign_up",
                        comment: ""
                    )
                ).foregroundColor(Color.black)
            }
        )
    }
}

struct SignInViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            SignInView()
                .preferredColorScheme(colorScheme)
        }
    }
}
