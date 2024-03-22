//
//  ContactRow.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import SwiftUI

struct ContactRow: View {
    
    var contact: Contact
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: contact.profileUrl)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            Text(contact.name)
        }
    }
}

struct ContactRowPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            ContactRow(contact:
                        Contact(
                            uuid: "uuid",
                            name: "string",
                            profileUrl: "https://static.significados.com.br/foto/hqdefault_sm.jpg"
                        )
            )
            .preferredColorScheme(colorScheme)
        }
    }
}
