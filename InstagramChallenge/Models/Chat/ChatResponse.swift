
import Foundation

struct ChatResponse: Decodable {
    var isSuccess: Bool?
    var code: Int?
    var message: String?
    var result: ChatResponseResult?
}

struct ChatResponseResult: Decodable {
    var userId: Int?
    var content: String?
}

