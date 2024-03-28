//
//  ChatView.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 28/03/24.
//

import SwiftUI

struct ChatView: View {
    
    let userName: String
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            chatView
            Spacer()
            userInputs
        }
    }
}

extension ChatView {
    var chatView: some View {
        ScrollView(
            showsIndicators: false,
            content: {
                ForEach(viewModel.messages, id: \.self) { message in
                    MessageViewRow(message: message)
                }
            }
        )
        .navigationTitle(userName)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

extension ChatView {
    var userInputs: some View {
        HStack{
            TextField(
                NSLocalizedString(
                    "message_view_user_message",
                    comment: ""
                ),
                text: $viewModel.text
            )
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding()
            .background(Color.white)
            .cornerRadius(24.0)
            .overlay(
                RoundedRectangle(cornerRadius: 24.0)
                    .strokeBorder(
                        Color(UIColor.separator),
                        style: StrokeStyle(lineWidth: 1.0)
                    )
            )
            
            Button {
                //TODO
            } label: {
                Text(
                    NSLocalizedString(
                        "message_view_user_message_send_button",
                        comment: ""
                    )
                )
                .padding()
                .background(Color("GreenColor"))
                .foregroundColor(Color.white)
                .cornerRadius(24.0)
            }
            .disabled(viewModel.text.isEmpty)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
    }
}

struct ChatViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            ChatView(userName: "Xablau")
                .preferredColorScheme(colorScheme)
        }
    }
}
