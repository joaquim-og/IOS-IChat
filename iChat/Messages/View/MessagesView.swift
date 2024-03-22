//
//  MessagesView.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 22/03/24.
//

import SwiftUI

struct MessagesView: View {
    
    @StateObject var viewModel = MessagesViewModel()
    
    var body: some View {
        Button(
            action: {
                viewModel.doLogout()
            },
            label: {
                Text("Xablau mensagens logout")
            }
        )
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
