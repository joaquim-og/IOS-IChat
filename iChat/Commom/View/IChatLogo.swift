//
//  IChatLogo.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import SwiftUI

struct IChatLogo: View {
    var body: some View {
        Image("chat_logo")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 48)
    }
}

struct IChatLogoPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            IChatLogo()
                .preferredColorScheme(colorScheme)
        }
    }
}
