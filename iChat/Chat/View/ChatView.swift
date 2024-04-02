//
//  ChatView.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 28/03/24.
//

import SwiftUI

struct ChatView: View {
    
    let contact: Contact
    
    @StateObject var viewModel = ChatViewModel()
    
    @State var textSize: CGSize = .zero
    
    @Namespace var bottomID
    
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
        ScrollViewReader { value in
            ScrollView(
                showsIndicators: false,
                content: {
                    VStack(spacing: 10) {
                        ForEach(viewModel.messages.indices, id: \.self) { index in
                            MessageViewRow(message: viewModel.messages[index])
                                .id(index)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 80)
                }
            )
            .navigationTitle(contact.name)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.onAppear(contact: contact)
                scrollToLastMessage(value)
            }
            .onChange(of: viewModel.messages.count) { _ in
                scrollToLastMessage(value)
            }
            
            Color.clear
                .frame(height: 1)
                .id(bottomID)
        }
    }
    
    private func scrollToLastMessage(_ value: ScrollViewProxy) {
        withAnimation {
            value.scrollTo(viewModel.messages.count - 1)
        }
    }
}

extension ChatView {
    var userInputs: some View {
        HStack{
            ZStack {
                TextEditor(text: $viewModel.text)
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
                    .frame(
                        maxHeight: (textSize.height + 50) > 100 ? 100 : textSize.height + 50
                    )
                
                Text(viewModel.text)
                    .opacity(0.0)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 21)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(ViewGeometry())
                    .onPreferenceChange(ViewSizeKey.self) {size in
                        textSize = size
                    }
            }
            
            Button {
                viewModel.sendMessage(contact: contact)
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
            ChatView(
                contact: Contact(
                    uuid: UUID().uuidString,
                    name: "Xablau",
                    profileUrl: "https://static.significados.com.br/foto/hqdefault_sm.jpg"
                )
            )
            .preferredColorScheme(colorScheme)
        }
    }
}
