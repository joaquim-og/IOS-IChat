//
//  IChatLoadingButtonView.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import SwiftUI

struct IChatLoadingButtonView: View {
    
    var action: () -> Void
    var buttonText: String
    var showProgress: Bool = false
    var disabled: Bool = false
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Text(showProgress ? " " : buttonText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .font(Font.system(.title3).bold())
                    .foregroundColor(.white)
                    .cornerRadius(24.0)
                    .background(Color("GreenColor"))
            }).disabled(disabled || showProgress)
                .cornerRadius(24.0)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .opacity(showProgress ? 1 : 0)
        }
    }
}

struct IChatLoadingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VStack {
                IChatLoadingButtonView(
                    action: {
                        print("Xablau")
                    },
                    buttonText: NSLocalizedString("sign_in_view_button_enter", comment: ""),
                    showProgress: false,
                    disabled: false)
            }.padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme($0)
        }
    }
}
