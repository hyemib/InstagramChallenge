
import Foundation

struct SignUpResponse: Decodable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
    var result: SignUpResponseResult?
}

struct SignUpResponseResult: Decodable {
    var jwt: String?
    var loginId: String?
}
