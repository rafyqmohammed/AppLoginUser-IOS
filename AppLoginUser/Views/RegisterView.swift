//
//  RegisterView.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct RegisterView: View {

    // MARK: - State Properties
    @State private var fullName: String = ""
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var registerError: String = ""

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

                    InputField(icon: "person", placeholder: "Full Name", text: $fullName)
                    InputField(icon: "envelope", placeholder: "Username / Email", text: $username, keyboardType: .emailAddress)
                    InputField(icon: "iphone.gen1", placeholder: "Phone Number", text: $phoneNumber, keyboardType: .phonePad)
                    InputField(icon: "key", placeholder: "Password", text: $password, isSecure: true)
                    InputField(icon: "key.fill", placeholder: "Confirm Password", text: $confirmPassword, isSecure: true)

                    // Error message
                    if !registerError.isEmpty {
                        Text(registerError)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // MARK: - Sign Up Button
                    Button(action: {
                        registerError = validate()
                        if registerError.isEmpty {
                            print("Register OK!")
                        }
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

    private func validate() -> String {
        if fullName.trimmingCharacters(in: .whitespaces).isEmpty { return "Full name is required." }
        if !username.contains("@") { return "Please enter a valid email." }
        if phoneNumber.isEmpty { return "Phone number is required." }
        if password.count < 6 { return "Password must be at least 6 characters." }
        if password != confirmPassword { return "Passwords do not match." }
        return ""
    }
}

// MARK: - Reusable InputField Component
struct InputField: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    @State private var isRevealed: Bool = false

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            Group {
                if isSecure && !isRevealed {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .keyboardType(keyboardType)
                }
            }
            if isSecure {
                Button(action: { isRevealed.toggle() }) {
                    Image(systemName: isRevealed ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
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
