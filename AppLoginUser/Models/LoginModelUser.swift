import Foundation

struct LoginRequest: Encodable {
    let username: String
    let password: String
    let grant_type: String
    let scope: String
    let client_id: String
    let client_secret: String

    

}

struct LoginResponse: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
    let refresh_token: String
    let scope: String
}
