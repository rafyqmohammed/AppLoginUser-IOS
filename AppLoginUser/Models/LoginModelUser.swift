import Foundation

// MARK: - Request
struct LoginRequest: Encodable {
    let username: String
    let password: String
    let grant_type: String
    let scope: String
    let client_id: String
    let client_secret: String
}

// MARK: - Top-level response
struct LoginApiResponse: Decodable {
    let token: TokenData
    let data: UserDataWrapper
}

struct TokenData: Decodable {
    let access_token: String
    let expires_in: Int
    let token_type: String
    let scope: String
    let createdAt: Int?
}

struct UserDataWrapper: Decodable {
    let user: UserModel
}

// MARK: - User
struct UserModel: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let mainEmail: String
    let mainPhone: String?
    let title: String?
    let function: String?
    let gender: String?
    let language: String?
    let type: String?
    let status: String?
    let isUaAdmin: Bool?

    var fullName: String { "\(firstName) \(lastName)" }
}
