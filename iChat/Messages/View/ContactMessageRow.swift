//
//  MessageRow.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 01/04/24.
//

import Foundation
import SwiftUI

struct ContactMessageRow: View {
    
    var contact: Contact
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: contact.profileUrl)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            
            VStack(
                alignment: .leading,
                content: {
                    Text(contact.name)
                    
                    if let msg = contact.lastMessage {
                        Text(msg)
                    }
                }
            )
            Spacer()
        }
    }
}

struct ContactMessageRowPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            ContactMessageRow(contact:
                                Contact(
                                    uuid: "uuid",
                                    name: "string",
                                    profileUrl: "https://static.significados.com.br/foto/hqdefault_sm.jpg",
                                    lastMessage: "Xablau last message"
                                )
            )
            .preferredColorScheme(colorScheme)
        }
    }
}
