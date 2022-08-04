
import Foundation

struct SignInResponse: Decodable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
    var result: SignInResponseResult?
}

struct SignInResponseResult: Decodable {
    var jwt: String?
    var loginId: String?
}

