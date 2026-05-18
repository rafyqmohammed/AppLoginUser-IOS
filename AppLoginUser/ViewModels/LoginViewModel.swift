//
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

    func login(username: String, password: String, appStore: AppStore) async {
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

                // Sauvegarder dans le Keychain et rediriger
                appStore.saveSession(token: response.token, user: response.data.user)
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
