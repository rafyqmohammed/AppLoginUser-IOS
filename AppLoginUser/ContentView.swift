//
//  ContentView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginVM = LoginViewModel()

    var body: some View {
        Group {
            if loginVM.success {
                UserInfo()
                    .environmentObject(loginVM)
            } else {
                LoginView()
                    .environmentObject(loginVM)
            }
        }
    }
}

#Preview {
    ContentView()
}
