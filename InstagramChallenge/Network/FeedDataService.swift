
import Foundation
import Alamofire

struct FeedDataService {
    
    private var feedsUrl = "\(Constant.BASE_URL)/app/feeds"
    
    func requestFetchFeeds(pageIndex: Int, delegate: HomeViewController) {
        let url = "\(feedsUrl)?pageIndex=\(pageIndex)&size=10"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: FeedsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("성공")
                        delegate.didSuccessFeedData(result: response.result!)
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2900: print("페이지 인덱스를 올바르게 입력해주세요.")
                        case 2901: print("페이지 사이즈를 올바르게 입력해주세요.")
                        case 3000: print("자동로그인 검증에 실패하였습니다. 다시 시도해주세요.")
                        case 3001: print("자동로그인이 만료되었습니다. 다시 로그인해주세요.")
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
