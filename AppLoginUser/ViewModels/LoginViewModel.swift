//
//  LoginViewModel.swift
//  United Associates
//
//  Created by Housni El aich on 4/4/2025.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {

    @Published var user:    UserModel? = nil
    @Published var token:   TokenData? = nil
    @Published var success: Bool   = false
    @Published var echec:   Bool   = false
    @Published var error:   String = ""
    @Published var wait:    Bool   = false
    // conservé pour compatibilité
    @Published var result:  [String: Any] = [:]

    func login(username: String, password: String) async {
        DispatchQueue.main.async { self.wait = true }

        await LoginAction(
            parameters: LoginRequest(
                username: username,
                password: password,
                grant_type: "password",
                scope: "ttp",
                client_id: "10020",
                client_secret: "UASecrectS#K$"
            )
        ).call(completion: { response in
            DispatchQueue.main.async {
                self.user    = response.data.user
                self.token   = response.token
                self.success = true
                self.echec   = false
                self.error   = ""
                self.wait    = false
            }
        }, reject: { message in
            DispatchQueue.main.async {
                self.error   = message
                self.user    = nil
                self.token   = nil
                self.success = false
                self.echec   = true
                self.wait    = false
            }
        })
    }
}
