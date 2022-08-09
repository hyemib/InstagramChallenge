
import Foundation

struct CommentResponse: Decodable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
    var result: [CommentResponseResult]?
}

struct CommentResponseResult: Decodable {
    var id: Int?
    var loginId: String?
    var commentText: String?
    var createdAt: String?
    var updatedAt: String?
}

