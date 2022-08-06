
import Foundation

struct MyPageResponse: Decodable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
    var result: MyPageResponseResult?
}

struct MyPageResponseResult: Decodable {
    var loginId: String?
    var realName: String?
    var followerCount: Int?
    var followingCount: Int?
    var feedCount: Int?
}
