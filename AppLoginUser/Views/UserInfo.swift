//
//  UserInfo.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct UserInfo: View {
    @EnvironmentObject var loginVM: LoginViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 24) {

                // Avatar
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // Nom
                Text(fullName)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)

                // Carte d'infos
                VStack(spacing: 16) {
                    infoRow(icon: "envelope",  label: "Email",        value: stringValue("user_name"))
                    infoRow(icon: "person",    label: "Identifiant",  value: stringValue("user_name"))
                    infoRow(icon: "key",       label: "Token type",   value: stringValue("token_type"))
                    infoRow(icon: "clock",     label: "Expire dans",  value: "\(intValue("expires_in"))s")
                    infoRow(icon: "globe",     label: "Scope",        value: stringValue("scope"))
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal, 20)

                Spacer()

                // Bouton Déconnexion
                Button(action: {
                    loginVM.success = false
                    loginVM.result = [:]
                }) {
                    Text("Se déconnecter")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.red)
                        .cornerRadius(25)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
        }
    }

    // MARK: - Helpers

    private var fullName: String {
        let first = stringValue("first_name")
        let last  = stringValue("last_name")
        if !first.isEmpty || !last.isEmpty {
            return "\(first) \(last)".trimmingCharacters(in: .whitespaces)
        }
        return stringValue("user_name").isEmpty ? "Utilisateur" : stringValue("user_name")
    }

    private func stringValue(_ key: String) -> String {
        loginVM.result[key] as? String ?? "—"
    }

    private func intValue(_ key: String) -> Int {
        loginVM.result[key] as? Int ?? 0
    }

    @ViewBuilder
    private func infoRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 24)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: 100, alignment: .leading)
            Text(value)
                .font(.subheadline)
                .bold()
                .foregroundColor(.primary)
                .lineLimit(1)
                .truncationMode(.middle)
            Spacer()
        }
    }
}

#Preview {
    UserInfo()
        .environmentObject(LoginViewModel())
}
