//
//  LoginView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var appStore: AppStore
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showRegister: Bool = false

    var body: some View {
        NavigationStack {
        ZStack {
            BackgroundView()
//            LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            //carte Blanche
            VStack(spacing: 20) {

                // Logo de l'application
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
                
                VStack{
                   // champ Username
                    HStack{
                        // icone
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Username / Email ", text: $username)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(25)
                    VStack{
                        // champ Password
                         HStack{
                             // icone
                             Image(systemName: "key")
                                 .foregroundColor(.gray)
                             SecureField("Password ", text: $password)
                         }
                         .padding()
                         .background(Color.gray.opacity(0.1))
                         .cornerRadius(25)
                        Button("forgot Password?"){
                            // Action
                        }
                        .font(.footnote)
                        .italic()
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                    }

                    // Message d'erreur
                    if !loginVM.error.isEmpty {
                        Text(loginVM.error)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // Bouton Login avec Degrade
                    Button(action: {
                        Task {
                            await loginVM.login(username: username, password: password, appStore: appStore)
                        }
                    }){
                        if loginVM.wait {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]),startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(25)
                        } else {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 150)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]),startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(25)
                        }
                    }
                    .disabled(loginVM.wait)
                    .padding(.top, 10)
                    //lien d'inscription
                    HStack{
                        Text("Don't have an account?")
                        Button("Register"){
                            showRegister = true
                        }
                        .foregroundColor(.red)
                        .bold()
                    }
                    .font(.footnote)
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30)
                .padding(20)
                .shadow(radius: 20)
            }
            .frame(width: 430)
           }
        .navigationDestination(isPresented: $showRegister) {
            RegisterView()
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
    
    private let imageURL = URL(string: "https://placehold.co/200x200/orange/orange.png")
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                
            case .failure, .empty:
                fallbackColor
                
            @unknown default:
                fallbackColor
            }
        }
        .ignoresSafeArea()
    }
    
    private var fallbackColor: some View {
        Color.orange
    }
}
