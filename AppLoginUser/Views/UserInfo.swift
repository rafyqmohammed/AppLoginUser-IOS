//
//  UserInfo.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import SwiftUI

struct UserInfo: View {
    @EnvironmentObject var appStore: AppStore
    @State private var tokenCopied = false

    private var data: KeychainManager.UserKeychainData? { appStore.userInfo }

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
                Text("\(data?.firstName ?? "") \(data?.lastName ?? "")")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)

                // Carte d'infos
                VStack(spacing: 16) {
                    infoRow(icon: "envelope",    label: "Email",     value: data?.mainEmail ?? "—")
                    infoRow(icon: "number",      label: "ID",        value: data.map { "\($0.id)" } ?? "—")

                    // Token — tap pour copier
                    infoRow(
                        icon:  tokenCopied ? "checkmark.circle.fill" : "doc.on.doc",
                        label: "Token",
                        value: tokenCopied ? "Copied!" : String((data?.access_token ?? "—").prefix(20)) + "...",
                        tint:  tokenCopied ? .green : .orange
                    )
                    .onTapGesture {
                        UIPasteboard.general.string = data?.access_token ?? ""
                        tokenCopied = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { tokenCopied = false }
                    }

                    infoRow(icon: "clock",       label: "Expire",    value: data.map { "\($0.expires_in)s" } ?? "—")
                    infoRow(icon: "phone",       label: "Phone",     value: data?.mainPhone ?? "—")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal, 20)

                Spacer()

                // Bouton Déconnexion
                Button(action: {
                    appStore.logout()
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
    private func infoRow(icon: String, label: String, value: String, tint: Color = .orange) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(tint)
                .frame(width: 28)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(width: 90, alignment: .leading)
            Text(value)
                .font(.subheadline)
                .bold()
                .foregroundColor(tint == .green ? .green : .primary)
                .lineLimit(1)
                .truncationMode(.middle)
            Spacer()
        }
    }
}

#Preview {
    UserInfo()
        .environmentObject(AppStore())
}
