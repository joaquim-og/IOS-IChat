//
//  ContentView.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 21/03/24.
//

import SwiftUI

struct SplashView: View {
    
    @StateObject var viewModel = SplashViewModel()
    
    var body: some View {
        NavigationView{
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .logged:
                MessagesView()
            case .unLogged:
                SignInView()
            case .error(let errorMsg):
                loadingView(error: errorMsg)
            case .none:
                loadingView()
            }
        }.onAppear{
            viewModel.checkIfuserIsLogged()
        }
    }
}

extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            IChatLogo()
            if let error = error {
                Text("").alert(isPresented: .constant(true)) {
                    Alert(title: Text("Habit"),
                          message: Text(error),
                          dismissButton: .default(Text("ok")) {}
                    )
                }
            }
            
        }
    }
}

struct SplashViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            SplashView()
                .preferredColorScheme(colorScheme)
        }
    }
}
