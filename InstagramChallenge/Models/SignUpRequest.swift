
import Foundation

struct SignUpRequest: Encodable {
    var realName: String = ""
    var password: String = ""
    var loginId: String = ""
    var birthDate: String = ""
    var phoneNumber: String = ""
}
