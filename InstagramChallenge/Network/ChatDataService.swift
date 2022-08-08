
import Alamofire

struct ChatDataService {
    
    private var getChatUrl = "\(Constant.BASE_URL)/app/chats"
    private var postChatUrl = "\(Constant.BASE_URL)/app/chat"

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
                        print("성공")
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
    
    func requestFetchPostChat(_ parameters: KakaoSignInRequest, delegate: UIViewController) {
        let url = "\(postChatUrl)"
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        Constant.jwtToken = (response.result?.jwt)!
                        delegate.didSuccessLogin()
                        print("카카오 로그인에 성공하였습니다.")
                        
                    } else {
                        delegate.didFailKakaoLogin()
                        switch response.code {
                        case 2100: print("카카오 계정이 존재하지 않습니다.")
                        case 2236: print("카카오 토큰이 잘못 되었습니다.")
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


