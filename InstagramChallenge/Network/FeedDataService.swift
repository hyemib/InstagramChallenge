
import Foundation
import Alamofire

struct FeedDataService {
    
    private var feedGetUrl = "\(Constant.BASE_URL)/app/feeds"
    private var feedPostUrl = "\(Constant.BASE_URL)/app/feed"
    private var feedPatchUrl = "\(Constant.BASE_URL)/app/feeds"
    private var feedUserUrl = "\(Constant.BASE_URL)/app/feeds/user"
    private var commentGetUrl = "\(Constant.BASE_URL)/app/feeds"
    private var commentPostUrl = "\(Constant.BASE_URL)/app/feeds"
    
    // 피드 조회
    func requestFetchGetFeed(pageIndex: Int, size: Int, delegate: HomeViewController) {
        let url = "\(feedGetUrl)?pageIndex=\(pageIndex)&size=\(size)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: FeedsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("피드 조회 성공")
                        
                        delegate.didSuccessFeedData(result: response.result!)
                        
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
    
    // 피드 생성
    func requestFetchPostFeed(_ parameters: FeedRequest, delegate: PostWriteViewController) {
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
                       
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2902: print("페이지피드 문구는 최소 1자부터 최대 1000자 이내로 입력해야합니다.")
                        case 2903: print("페이지피드 컨텐츠는 최소 1장부터 최대 5장 이내로 선택해야합니다.")
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
    
    // 피드 수정
    func requestFetchUpdateFeed(feedId: Int, delegate: PostUpdateViewController) {
        let url = "\(feedPatchUrl)/\(feedId)/"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .patch, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: FeedsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("피드 수정 성공.")
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2904: print("피드 아이디를 올바르게 입력해주세요.")
                        case 2908: print("피드가 존재하지않습니다.")
                        case 2909: print("본인의 피드만 수정 가능합니다.")
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
    
    
    // 피드 삭제
    func requestFetchDeleteFeed(feedId: Int, delegate: RemoveViewController) {
        let url = "\(feedPatchUrl)/\(feedId)/delete-status"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .patch, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: FeedsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("피드 삭제 성공.")
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2904: print("피드 아이디를 올바르게 입력해주세요.")
                        case 2908: print("피드가 존재하지않습니다.")
                        case 2909: print("본인의 피드만 수정 가능합니다.")
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
    
    // 특정 유저 피드 조회
    func requestFetchGetFeedUser(pageIndex: Int, loginId: String, delegate: MyFeedViewController) {
        let url = "\(feedUserUrl)?pageIndex=\(pageIndex)&size=9&loginId=\(loginId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: FeedsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("특정 유저 피드 조회 성공")
                        delegate.setMyPageFeed(resut: response.result!)
                        
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2103: print("계정 아이디를 입력해주세요.")
                        case 2104: print("계정 아이디를 20자리 미만으로 입력해주세요.")
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
    
    // 댓글 조회
    func requestFetchGetComment(feedId:Int, pageIndex: Int, size: Int, delegate: CommentViewController) {
        let url = "\(commentGetUrl)/\(feedId)/comments?pageIndex=\(pageIndex)&size=\(size)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: CommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("댓글 조회 성공")
                        delegate.setGetCommentData(result: response.result!)
                        
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2900: print("페이지 인덱스를 올바르게 입력해주세요.")
                        case 2901: print("페이지 사이즈를 올바르게 입력해주세요.")
                        case 2904: print("피드 아이디를 올바르게 입력해주세요.")
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
    
    // 댓글 추가
    func requestFetchPostComment(_ parameters: CommentRequest, feedId: Int, delegate: CommentViewController) {
        let url = "\(commentPostUrl)/\(feedId)/comment?feedId=\(feedId)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: CommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        delegate.didSuccessAddComment()
                        
                        print("댓글 생성에 성공하였습니다.")
                        
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2904: print("피드 아이디를 올바르게 입력해주세요.")
                        case 2905: print("댓글 문구는 최소 1자부터 최대 200자 이내로 입력해야합니다..")
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
