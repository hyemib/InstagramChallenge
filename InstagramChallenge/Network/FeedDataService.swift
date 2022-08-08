
import Foundation
import Alamofire

struct FeedDataService {
    
    private var feedGetUrl = "\(Constant.BASE_URL)/app/feeds"
    private var feedPostUrl = "\(Constant.BASE_URL)/app/feed"
    
    // 피드 조회
    func requestFetchGetFeed(pageIndex: Int, delegate: HomeViewController) {
        let url = "\(feedGetUrl)?pageIndex=\(pageIndex)&size=10"
        
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
    
    // 피드 생성
    func requestFetchPostFeed(_ parameters: FeedRequest, delegate: WritingViewController) {
        let url = "\(feedPostUrl)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: FeedsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("피드 생성 성공.")
                        delegate.didSuccessLogin()
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2902: print("페이지피드 문구는 최소 1자부터 최대 1000자 이내로 입력해야합니다.")
                        case 2903: print("페이지피드 컨텐츠는 최소 1장부터 최대 5장 이내로 선택해야합니다.")
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
