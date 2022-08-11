
import Alamofire

struct ChatDataService {
    
    private var getChatUrl = "\(Constant.BASE_URL)/app/chats"
    private var postChatUrl = "\(Constant.BASE_URL)/app/chat"

    
    // 채팅 조회
    func requestFetchGetChat(pageIndex: Int, size:Int, delegate: ChatViewController) {
        let url = "\(getChatUrl)?pageIndex=\(pageIndex)&size=\(size)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: ChatsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("채팅 조회에 성공하였습니다.")
                        delegate.didSuccessGetChatData(result: response.result!)
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2900: print("페이지 인덱스를 올바르게 입력해주세요.")
                        case 2901: print("페이지 사이즈를 올바르게 입력해주세요.")
                        case 3000: print("자동로그인 검증에 실패하였습니다. 다시 시도해주세요.")
                        case 3001:
                            print("자동로그인이 만료되었습니다. 다시 로그인해주세요.")
                            delegate.expireToken()
                        case 4000: print("데이터 베이스 커텍션 에러")
                        case 4001: print("서버 에러")
                        case 4002: print("데이터 베이스 쿼리 에러")
                        default: return
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
        
                }
            }
    }
    
    // 채팅 보내기
    func requestFetchPostChat(_ parameters: ChatRequest, delegate: ChatViewController) {
        let url = "\(postChatUrl)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .responseDecodable(of: ChatResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("채팅 보내기에 성공하였습니다.")
                        delegate.didSuccessPostChat()
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2800: print("채팅 본문은 최소 1자부터 최대 200자 이내로 입력해야합니다.")
                        case 3000: print("자동로그인 검증에 실패하였습니다. 다시 시도해주세요.")
                        case 3001:
                            print("자동로그인이 만료되었습니다. 다시 로그인해주세요.")
                            delegate.expireToken()
                        case 4000: print("데이터 베이스 커텍션 에러")
                        case 4001: print("서버 에러")
                        case 4002: print("데이터 베이스 쿼리 에러")
                        default: return
                        }
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
        
                }
            }
            
    }
}


