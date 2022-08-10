
import Foundation

class CommentContents {
    var feedLoginId: String
    var feedText: String
    var feedCreatedAt: String
    
    init(feedLoginId: String, feedText: String, feedCreatedAt: String) {
        self.feedLoginId = feedLoginId
        self.feedText = feedText
        self.feedCreatedAt = feedCreatedAt
    }
}
