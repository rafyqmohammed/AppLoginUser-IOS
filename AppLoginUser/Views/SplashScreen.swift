//
//  SplashScreen.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 27/2/2026.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var appStore: AppStore

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Logo
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(radius: 15)

                Text("AppLoginUser")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .padding(.top, 20)
            }
        }
        .onAppear {
            // Attendre 2 secondes puis vérifier le Keychain
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                appStore.checkSession()
            }
        }
    }
}

#Preview {
    SplashScreen()
        .environmentObject(AppStore())
}
