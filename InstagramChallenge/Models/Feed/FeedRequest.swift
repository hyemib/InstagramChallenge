
import Foundation

struct FeedRequest: Encodable {
    var feedText: String
    var contentsUrls: [String]
}
