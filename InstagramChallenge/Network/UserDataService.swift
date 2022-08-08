
import Alamofire

struct UserDataService {
    
    private var signUpUrl = "\(Constant.BASE_URL)/app/sign-up"
    private var signInUrl = "\(Constant.BASE_URL)/app/sign-in"
    private var kakaoSignUpUrl = "\(Constant.BASE_URL)/app/kakao-sign-up"
    private var kakaoSignInUrl = "\(Constant.BASE_URL)/app/kakao-sign-in"
    private var authSignInUrl = "\(Constant.BASE_URL)/app/auto-sign-in"
    private var checkDuplicateLoginIdUrl = "\(Constant.BASE_URL)/app/check-duplicate-login-id"
    private var myPageUrl = "\(Constant.BASE_URL)/app/users"
    
    // 자체 회원가입
    func requestFetchSignUp(_ parameters: SignUpRequest, delegate: FinalConfirmationViewController) {
        let url = "\(signUpUrl)"
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        Constant.jwtToken = (response.result?.jwt)!
                        delegate.didSuccessJoin()
                        print("회원가입에 성공하였습니다.")
                    } else {
                        switch response.code {
                        case 2103: print("계정 아이디를 입력해주세요.")
                        case 2104: print("계정 아이디는 20자리 미만으로 입력해주세요.")
                        case 2106: print("비밀번호를 입력 해주세요.")
                        case 2107: print("비밀번호는 20자리 미만으로 입력해주세요.")
                        case 2111: print("생일을 올바르게 입력 해주세요.")
                        case 2112: print("번호를 입력 해주세요.")
                        case 2113: print("번호를 11자리 미만으로 입력해주세요.")
                        case 2114: print("핸드폰 번호를 숫자만으로 입력해주세요.")
                        case 2115: print("아이디를 숫자와 소문자 영문 혹은_와.으로만 입력해주세요.")
                        case 2116: print("실명을 입력 해주세요.")
                        case 2117: print("실명을 20자 미만으로 입력해주세요.")
                        case 2330: print("중복된 아이디입니다.")
                        case 2232: print("아이디가 잘못 되었습니다.")
                        case 2233: print("비밀번호가 잘못 되었습니다.")
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
    
    // 자체 로그인
    func requestFetchSignIn(_ parameters: SignInRequest, delegate: LoginViewController) {
        let url = "\(signInUrl)"
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        Constant.jwtToken = (response.result?.jwt)!
                        delegate.didSuccessLogin()
                        print("로그인에 성공하였습니다.")
                    } else {
                        delegate.didFailLogin()
                        switch response.code {
                        case 2103: print("계정 아이디를 입력해주세요.")
                        case 2104: print("계정 아이디는 20자리 미만으로 입력해주세요.")
                        case 2106: print("비밀번호를 입력 해주세요.")
                        case 2107: print("비밀번호는 20자리 미만으로 입력해주세요.")
                        case 2232: print("아이디가 잘못 되었습니다.")
                        case 2233: print("비밀번호가 잘못 되었습니다.")
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
    
    // 카카오 회원가입
    func requestFetchKakaoSignUp(_ parameters: KakaoSignUpRequest, delegate: FinalConfirmationViewController) {
        let url = "\(kakaoSignUpUrl)"
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        Constant.jwtToken = (response.result?.jwt)!
                        delegate.didSuccessJoin()
                        print("카카오 회원가입에 성공하였습니다.")
                    } else {
                        switch response.code {
                        case 2100: print("카카오 계정이 존재하지 않습니다.")
                        case 2103: print("계정 아이디를 입력해주세요.")
                        case 2104: print("계정 아이디는 20자리 미만으로 입력해주세요.")
                        case 2111: print("생일을 올바르게 입력 해주세요.")
                        case 2113: print("번호를 11자리 미만으로 입력해주세요.")
                        case 2114: print("핸드폰 번호를 숫자만으로 입력해주세요.")
                        case 2115: print("아이디를 숫자와 소문자 영문 혹은_와.으로만 입력해주세요.")
                        case 2116: print("실명을 입력 해주세요.")
                        case 2117: print("실명을 20자 미만으로 입력해주세요.")
                        case 2336: print("카카오 토큰이 잘못 되었습니다.")
                        case 2237: print("이미 카카오 계정이 존재합니다.")
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
    
    // 카카오 로그인
    func requestFetchKakaoSignIn(_ parameters: KakaoSignInRequest, delegate: UIViewController) {
        let url = "\(kakaoSignInUrl)"
        
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
    
    // 자동 로그인
    func requestFetchAutoSignIn(delegate: LoginViewController) {
        let url = "\(authSignInUrl)"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("자동로그인 검증이 완료되었습니다.")
                        delegate.didSuccessLogin()
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 3000: print("자동로그인 검증에 실패하였습니다. 다시 시도해주세요.")
                        case 3001: print("자동로그인 만료되었습니다. 다시 로그인해주세요.")
                        default: return
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
        
                }
            }
    }
    
    // 아이디 중복 조회
    func requestFetchCheckDuplicateLoginId(loginId: String, delegate: UserNameViewController) {
        let url = "\(checkDuplicateLoginIdUrl)?loginId=\(loginId)"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: AuthResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("성공")
                        delegate.didSuceessUserName()
                    } else {
                        delegate.didFailUserName()
                        switch response.code {
                        case 2103: print("계정 아이디를 입력해주세요.")
                        case 2104: print("계정 아이디는 20자리 미만으로 입력해주세요.")
                        case 2230: print("중복된 아이디입니다.")
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
    
    // 마이페이지 조회
    func requestFetchMyPage(loginId: String, delegate: MyPageViewController) {
        let url = "\(myPageUrl)/\(loginId)/my-page"
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                    "X-ACCESS-TOKEN":"\(Constant.jwtToken)"]
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: MyPageResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess)! {
                        print("성공")
                        delegate.setMyPageView(result: response.result!)
                    } else {
                        switch response.code {
                        case 2000: print("JWT 토큰을 입력해주세요.")
                        case 2103: print("계정 아이디를 입력해주세요.")
                        case 2104: print("계정 아이디는 20자리 미만으로 입력해주세요.")
                        case 2223: print("해당 회원이 존재하지 않습니다.")
                        case 2232: print("아이디가 잘못 되었습니다.")
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
