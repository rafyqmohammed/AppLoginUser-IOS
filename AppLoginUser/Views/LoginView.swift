//
//  LoginView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    @EnvironmentObject var appStore: AppStore
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showRegister: Bool = false
    @State private var showForgotAlert: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()

                VStack(spacing: 20) {

                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)

                    Text("WELCOME !!!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    VStack(spacing: 20) {

                        InputField(icon: "envelope", placeholder: "Username / Email", text: $username, keyboardType: .emailAddress)

                        VStack(alignment: .trailing, spacing: 8) {
                            InputField(icon: "key", placeholder: "Password", text: $password, isSecure: true)

                            Button("forgot Password?") {
                                showForgotAlert = true
                            }
                            .font(.footnote)
                            .italic()
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                        }

                        if !loginVM.error.isEmpty {
                            Text(loginVM.error)
                                .font(.footnote)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }

                        Button(action: {
                            Task {
                                await loginVM.login(username: username, password: password, appStore: appStore)
                            }
                        }) {
                            if loginVM.wait {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(25)
                                    .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
                            } else {
                                Text("Login")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(25)
                                    .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
                            }
                        }
                        .disabled(loginVM.wait)
                        .padding(.top, 15)

                        HStack {
                            Text("Don't have an account?")
                            Button("Register") {
                                showRegister = true
                            }
                            .foregroundColor(.red)
                            .bold()
                        }
                        .font(.footnote)
                        .padding(.top, 5)
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(35)
                    .padding(.horizontal, 24)
                    .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 10)
                }
                .frame(maxWidth: 430)
            }
            .navigationDestination(isPresented: $showRegister) {
                RegisterView()
            }
            .alert("Reset Password", isPresented: $showForgotAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please contact your administrator to reset your password.")
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
        .environmentObject(AppStore())
}

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.orange, .red]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
