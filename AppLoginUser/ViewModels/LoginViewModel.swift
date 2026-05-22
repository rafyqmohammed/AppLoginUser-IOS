//
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var error: String = ""
    @Published var wait:  Bool   = false

    func login(username: String, password: String, appStore: AppStore) async {
        await MainActor.run { self.wait = true }

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
            Task { @MainActor in
                self.error = ""
                self.wait  = false
                appStore.saveSession(token: response.token, user: response.data.user)
            }
        }, reject: { message in
            Task { @MainActor in
                self.error = message
                self.wait  = false
            }
        })
    }
}
