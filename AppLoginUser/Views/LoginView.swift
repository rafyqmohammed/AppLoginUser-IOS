//
//  LoginView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            //BackgroundView()
            LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            //carte Blanche
            VStack(spacing: 20) {
                Text("WELCOME")
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
                             TextField("Password ", text: $password)
                             
                                 
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
                    // Bouton Login avec Degrade
                    Button(action: {
                        print("Login presse")
                    }){
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]),startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(25)
                    }
                    .padding(.top, 10)
                    //lien d'inscription
                    HStack{
                        Text("Don't have an account?")
                        Button("Resgiter"){
                            //action
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
                
//                .padding()
//                .background(){
//                    Rectangle()
//                        .foregroundStyle(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 16, style:.continuous))
//                        .shadow(radius: 15)
//                    
//                }
            }
            
         
            
            
           }
    }
}

#Preview {
    LoginView()
}

//struct BackgroundView: View {
//    
//    private let imageURL = URL(string: "https://placehold.co/200x200/orange/orange.png")
//    
//    var body: some View {
//        AsyncImage(url: imageURL) { phase in
//            switch phase {
//                
//            case .success(let image):
//                image
//                    .resizable()
//                    .scaledToFill()
//                
//            case .failure, .empty:
//                fallbackColor
//                
//            @unknown default:
//                fallbackColor
//            }
//        }
//        .ignoresSafeArea()
//    }
//    
//    private var fallbackColor: some View {
//        Color.orange
//    }
//}
