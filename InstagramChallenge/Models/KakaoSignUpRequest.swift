
import Foundation

struct KakaoSignUpRequest: Encodable {
    var accessToken: String = ""
    var realName: String = ""
    var birthDate: String = ""
    var loginId: String = ""
    var phoneNumber: String = ""
}
