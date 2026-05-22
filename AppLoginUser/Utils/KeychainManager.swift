//
//  KeychainManager.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 27/2/2026.
//

import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()
    private let service = "com.apploginuser"

    private init() {}

    // MARK: - Données à stocker

    struct UserKeychainData: Codable {
        let access_token: String
        let expires_in: Int
        let createdAt: Int?
        let id: Int
        let firstName: String
        let lastName: String
        let mainEmail: String
        let mainPhone: String?
        let avatarUrl: String?
    }




    // MARK: - Save

    func save(data: UserKeychainData) -> Bool {
        // Supprimer l'ancien avant de sauvegarder
        delete()

        guard let encoded = try? JSONEncoder().encode(data) else { return false }

        let query: [String: Any] = [
            kSecClass as String:       kSecClassGenericPassword,
            kSecAttrService as String:  service,
            kSecAttrAccount as String:  "userInfo",
            kSecValueData as String:    encoded
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    // MARK: - Load

    func load() -> UserKeychainData? {
        let query: [String: Any] = [
            kSecClass as String:       kSecClassGenericPassword,
            kSecAttrService as String:  service,
            kSecAttrAccount as String:  "userInfo",
            kSecReturnData as String:   true,
            kSecMatchLimit as String:   kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess, let data = result as? Data else { return nil }

        return try? JSONDecoder().decode(UserKeychainData.self, from: data)
    }

    // MARK: - Delete

    @discardableResult
    func delete() -> Bool {
        let query: [String: Any] = [
            kSecClass as String:       kSecClassGenericPassword,
            kSecAttrService as String:  service,
            kSecAttrAccount as String:  "userInfo"
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }

    // MARK: - Check

    func hasData() -> Bool {
        return load() != nil
    }
}
