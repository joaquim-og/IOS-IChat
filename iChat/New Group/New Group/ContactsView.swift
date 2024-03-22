//
//  ContactsView.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import SwiftUI

struct ContactsView: View {
    
    @StateObject var viewModel = ContactsViewModel()
    
    
    var body: some View {
        VStack{
            List(viewModel.contacts, id: \.self) { contact in
                ContactRow(contact: contact)
            }
        }.onAppear{
            viewModel.getContacts()
        }
    }
}


struct ContactsViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            ContactsView()
                .preferredColorScheme(colorScheme)
        }
    }
}
