//
//  UserInfo.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct UserInfo: View {
    @EnvironmentObject var loginVM: LoginViewModel

    private var user: UserModel? { loginVM.user }
    private var token: TokenData? { loginVM.token }

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

                // Nom complet
                Text(user?.fullName ?? "Utilisateur")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)

                // Fonction + Titre
                if let fonction = user?.function, !fonction.isEmpty {
                    Text(fonction)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                }

                // Carte d'infos
                VStack(spacing: 16) {
                    infoRow(icon: "person.text.rectangle", label: "Titre",     value: user?.title ?? "—")
                    infoRow(icon: "envelope",              label: "Email",     value: user?.mainEmail ?? "—")
                    infoRow(icon: "phone",                 label: "Téléphone", value: user?.mainPhone ?? "—")
                    infoRow(icon: "briefcase",             label: "Fonction",  value: user?.function ?? "—")
                    infoRow(icon: "globe",                 label: "Langue",    value: user?.language ?? "—")
                    infoRow(icon: "person.badge.key",       label: "Type",      value: user?.type ?? "—")
                    infoRow(icon: "number",                label: "ID",        value: user.map { "\($0.id)" } ?? "—")
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
                    loginVM.user    = nil
                    loginVM.token   = nil
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

    @ViewBuilder
    private func infoRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 28)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: 90, alignment: .leading)
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
