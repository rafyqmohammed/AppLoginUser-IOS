//
//  ContentView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appStore: AppStore = AppStore()
   //@StateObject var loginVM: LoginViewModel = LoginViewModel()

    var body: some View {
        switch appStore.page {
        case "splash":
            SplashScreen()
                .environmentObject(appStore)
        case "login":
            LoginView()
                .environmentObject(appStore)
               // .environmentObject(loginVM)
        case "userinfo":
            UserInfo()
                .environmentObject(appStore)
        default:
            SplashScreen()
                .environmentObject(appStore)
        }
    }
}

#Preview {
    ContentView()
}
