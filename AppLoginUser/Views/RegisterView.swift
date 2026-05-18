//
//  RegisterView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI
import Combine

struct RegisterView: View {
    
    // MARK: - State Properties
    @State private var fullName: String = ""
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            BackgroundView()
            
            VStack(spacing: 20)  {
                
                // MARK: - Title
                Text("REGISTER")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                // MARK: - Form Card
                VStack(spacing: 15) {
                    
                    // Full Name Field
                    InputField(icon: "person", placeholder: "Full Name", text: $fullName)
                    
                    // Username / Email Field
                    InputField(icon: "envelope", placeholder: "Username / Email", text: $username, keyboardType: .emailAddress)
                    
                    // Phone Number Field
                    InputField(icon: "iphone.gen1", placeholder: "Phone Number", text: $phoneNumber, keyboardType: .phonePad)
                    
                    // Password Field
                    InputField(icon: "key", placeholder: "Password", text: $password, isSecure: true)
                    
                    // MARK: - Sign Up Button
                    Button(action: {
                        print("Register OK!")
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.red, .orange]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                            .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                    .padding(.top, 15)
                    
                    // MARK: - Sign In Link
                    HStack {
                        Text("Already a member?")
                        Button("Sign in") {
                            dismiss()
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
            .frame(maxWidth: 450)
        }
    }
}

// MARK: - Reusable InputField Component
struct InputField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .keyboardType(keyboardType)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(25)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        RegisterView()
    }
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
