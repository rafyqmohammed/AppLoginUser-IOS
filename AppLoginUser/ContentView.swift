//
//  ContentView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appStore: AppStore = AppStore()

    var body: some View {
        switch appStore.page {
        case .splash:
            SplashScreen()
                .environmentObject(appStore)
        case .login:
            LoginView()
                .environmentObject(appStore)
        case .userInfo:
            UserInfo()
                .environmentObject(appStore)
        }
    }
}

#Preview {
    ContentView()
}
