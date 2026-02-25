//
//  LoginViewModel.swift
//  United Associates
//
//  Created by Housni El aich on 4/4/2025.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {

    @Published var result:  [String: Any] = [:]
    @Published var success: Bool   = false
    @Published var echec:   Bool   = false
    @Published var error:   String = ""
    @Published var wait:    Bool   = false

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
        ).call(completion: { success in
            DispatchQueue.main.async {
                self.result = success
                self.success = true
                self.echec = false
                self.error = ""
                self.wait = false
            }
        }, reject: { message in
            DispatchQueue.main.async {
                self.error = message
                self.result = [:]
                self.success = false
                self.echec = true
                self.wait = false
            }
        })
    }
}
