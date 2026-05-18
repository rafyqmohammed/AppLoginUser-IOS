//
//  LoginView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI
import Combine

struct LoginView: View {
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    //@EnvironmentObject var loginVM: LoginViewModel
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
                
                VStack(spacing: 20) {
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
                    
                    VStack(alignment: .trailing, spacing: 8) {
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
                        .padding(.trailing, 10)
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
                                .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
                        } else {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]),startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(25)
                                .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
                        }
                    }
                    .disabled(loginVM.wait)
                    .padding(.top, 15)
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
