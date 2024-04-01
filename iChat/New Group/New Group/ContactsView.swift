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
            
            if (viewModel.uiState == ContactsUiState.loading){
                ProgressView()
            }
            
            List(viewModel.contacts, id: \.self) { contact in
                NavigationLink {
                    ChatView(
                        toId: contact.uuid,
                        userName: contact.name
                    )
                } label: {
                    ContactRow(contact: contact)
                }
            }
        }.onAppear{
            viewModel.getContacts()
        }.navigationTitle(NSLocalizedString(
            "messages_view_toolbar_contacts",
            comment: ""
        ))
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
