
import Foundation

struct ChatsResponse: Decodable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
    var result: [ChatsResponseResult]?
}

struct ChatsResponseResult: Decodable {
    var chatId: Int?
    var userId: Int?
    var loginId: String?
    var content: String?
    var createdAt: String?
    var updatedAt: String?
}
