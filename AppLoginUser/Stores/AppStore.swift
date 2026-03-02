//
//  AppStore.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 27/2/2026.
//

import Foundation
import Combine

class AppStore: ObservableObject {
    @Published var page: String = "splash"
    @Published var userInfo: KeychainManager.UserKeychainData? = nil

    /// Vérifie si des données existent dans le Keychain
    /// et redirige vers la bonne page
    func checkSession() {
        if let data = KeychainManager.shared.load() {
            userInfo = data
            page = "userinfo"
        } else {
            page = "login"
        }
    }

    /// Sauvegarde les données user dans le Keychain après login
    func saveSession(token: TokenData, user: UserModel) {
        let data = KeychainManager.UserKeychainData(
            access_token: token.access_token,
            expires_in:   token.expires_in,
            createdAt:    token.createdAt,
            id:           user.id,
            firstName:    user.firstName,
            lastName:     user.lastName,
            mainEmail:    user.mainEmail,   
            mainPhone:   user.mainPhone,
            avatarUrl:    nil
        )
        KeychainManager.shared.save(data: data)
        userInfo = data
        page = "userinfo"
    }

    /// Supprime les données du Keychain et retourne au login
    func logout() {
        KeychainManager.shared.delete()
        userInfo = nil
        page = "login"
    }
}
