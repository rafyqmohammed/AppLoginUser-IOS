//
//  AppStore.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 27/2/2026.
//

import Foundation
import Combine

enum AppPage {
    case splash, login, userInfo
}

class AppStore: ObservableObject {
    @Published var page: AppPage = .splash
    @Published var userInfo: KeychainManager.UserKeychainData? = nil

    func checkSession() {
        guard let data = KeychainManager.shared.load() else {
            page = .login
            return
        }
        if isTokenExpired(data) {
            KeychainManager.shared.delete()
            page = .login
        } else {
            self.userInfo = data
            page = .userInfo
        }
    }

    func saveSession(token: TokenData, user: UserModel) {
        let data = KeychainManager.UserKeychainData(
            access_token: token.access_token,
            expires_in:   token.expires_in,
            createdAt:    token.createdAt,
            id:           user.id,
            firstName:    user.firstName,
            lastName:     user.lastName,
            mainEmail:    user.mainEmail,
            mainPhone:    user.mainPhone,
            avatarUrl:    nil
        )
        KeychainManager.shared.save(data: data)
        userInfo = data
        page = .userInfo
    }

    func logout() {
        KeychainManager.shared.delete()
        userInfo = nil
        page = .login
    }

    private func isTokenExpired(_ data: KeychainManager.UserKeychainData) -> Bool {
        guard let createdAt = data.createdAt else { return false }
        let expiryDate = Date(timeIntervalSince1970: Double(createdAt + data.expires_in))
        return expiryDate < Date()
    }
}
