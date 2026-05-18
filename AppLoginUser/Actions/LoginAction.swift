//
//  LoginAction.swift
//  AppLoginUser
//
//  Created by tamtam-8 on 25/2/2026.
//

import Foundation

class LoginAction {

    private let parameters: LoginRequest
    private let loginURL = URL(string: "https://api.tamtam.pro/token")!

    init(parameters: LoginRequest) {
        self.parameters = parameters
    }

    func call(
        completion: @escaping (LoginApiResponse) -> Void,
        reject:     @escaping (String) -> Void
    ) async {
        // Construction du body en x-www-form-urlencoded
        let bodyParts = [
            "username=\(parameters.username)",
            "password=\(parameters.password)",
            "grant_type=\(parameters.grant_type)",
            "scope=\(parameters.scope)",
            "client_id=\(parameters.client_id)",
            "client_secret=\(parameters.client_secret)"
        ]
        let bodyString = bodyParts
            .map { $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? $0 }
            .joined(separator: "&")

        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json,app=offfcourse-ios", forHTTPHeaderField: "Accept")
        request.httpBody = bodyString.data(using: .utf8)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
//            print("La data requête est !!!! \(String(data: data, encoding: .utf8) ?? "Impossible de décoder en UTF-8")")

            guard let http = response as? HTTPURLResponse else {
                reject("Réponse invalide du serveur.")
                return
            }

            guard (200..<300).contains(http.statusCode) else {
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let detail = json["error_description"] as? String ?? json["detail"] as? String {
                    reject(detail)
                } else {
                    reject("Erreur \(http.statusCode) — vérifiez vos identifiants.")
                }
                return
            }

            do {
                let decoded = try JSONDecoder().decode(LoginApiResponse.self, from: data)
                completion(decoded)
            } catch {
                reject("Erreur de décodage : \(error.localizedDescription)")
            }

        } catch {
            reject(error.localizedDescription)
        }
    }
}
