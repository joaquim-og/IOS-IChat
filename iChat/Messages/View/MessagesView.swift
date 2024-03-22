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
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Xablau marcação")
            }
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
