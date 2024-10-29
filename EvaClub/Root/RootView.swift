//
//  RootView.swift
//  EvaClub
//
//  Created by D K on 25.10.2024.
//

import SwiftUI

struct RootView: View {    
    
    @StateObject private var viewModel = AuthViewModel()
    @State var isSecured = false
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                if isSecured {
                    PassView() { isSecured.toggle() }
                } else {
                    TabMainView()
                        .environmentObject(viewModel)
                }
                
            } else {
                LoginView(viewModel: viewModel)
            }
        }
        .onAppear {
            if let _ = UserDefaults.standard.string(forKey: "code") {
                isSecured = true
            }
        }
    }

}

#Preview {
    RootView()
}
