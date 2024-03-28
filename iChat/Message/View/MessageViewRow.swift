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
        Text(message.text)
            .background(Color(white: 0.95))
            .frame(maxWidth: .infinity, alignment: message.isMe ? .leading : .trailing)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.leading, message.isMe ? 0 : 50)
            .padding(.trailing, message.isMe ? 50 : 0)
            .padding(.vertical, 5)
    }
}
