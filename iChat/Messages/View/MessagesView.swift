//
//  MessagesView.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import SwiftUI

struct MessagesView: View {
    
    @StateObject var viewModel = MessagesViewModel()
    
    private let contactsString = NSLocalizedString("messages_view_toolbar_contacts", comment: "")
    private let logoutString = NSLocalizedString("messages_view_toolbar_logout", comment: "")
    private let messagesTitle = NSLocalizedString("messages_view_messages", comment: "")
    
    var body: some View {
        
        NavigationView {
            VStack {
                if (viewModel.uiState == MessagesUiState.loading){
                    ProgressView()
                }
                
                List (viewModel.contacts, id: \.self) { contact in
                    NavigationLink {
                        ChatView(contact: contact)
                    } label: {
                        ContactMessageRow(contact: contact)
                    }
                }
                
            }.onAppear{
                viewModel.getContacts()
            }
            .navigationTitle(messagesTitle)
            .toolbar{
                ToolbarItem(
                    id: contactsString,
                    placement: ToolbarItemPlacement.navigationBarTrailing,
                    showsByDefault: true,
                    content: {
                        NavigationLink(
                            contactsString,
                            destination: ContactsView()
                        )
                    }
                )
                ToolbarItem(
                    id: logoutString,
                    placement: ToolbarItemPlacement.navigationBarTrailing,
                    showsByDefault: true,
                    content: {
                        Button(
                            action: {
                                viewModel.doLogout()
                            },
                            label: {
                                Text(logoutString)
                            }
                        )
                    }
                )
            }
        }
        
        
    }
}
struct MessagesViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            MessagesView()
                .preferredColorScheme(colorScheme)
        }
    }
}
