
import Foundation

struct FeedsResponse: Decodable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
    var result: [FeedsResponseResult]?
}

struct FeedsResponseResult: Decodable {
    var feedId: Int?
    var feedLoginId: String?
    var feedText: String?
    var feedCreatedAt: String?
    var feedUpdatedAt: String?
    var feedCommentCount: Int?
    var contentsList: [ContentsListResult]?
}

struct ContentsListResult: Decodable {
    var contentsId: Int?
    var contentsUrl: String?
    var createdAt: String?
    var updatedAt: String?
}
