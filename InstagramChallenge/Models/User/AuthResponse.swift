
import Foundation

struct AuthResponse: Decodable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
    var result: AuthResponseResult?
}

struct AuthResponseResult: Decodable {
    var jwt: String?
    var loginId: String?
}
