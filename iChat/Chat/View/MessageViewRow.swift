//
//  MessageViewRow.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 28/03/24.
//

import SwiftUI

struct MessageViewRow: View {
    
    let message: Message
    
    var body: some View {
        VStack(
            alignment: .leading,
            content: {
                Text(message.text)
                    .padding(.vertical, 5)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 10)
                    .background(Color(white: 0.95))
                    .frame(maxWidth: 260, alignment: message.isMe ? .trailing : .leading)
            }
        ).frame(maxWidth: .infinity, alignment: message.isMe ? .trailing : .leading)
    }
}
