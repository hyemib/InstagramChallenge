
import Alamofire

struct AuthDataService {
    
    private var signUpUrl = "\(Constant.BASE_URL)/app/sign-up"
    private var signInUrl = "\(Constant.BASE_URL)/app/sign-in"
    private var kakaoSignUpUrl = "\(Constant.BASE_URL)/app/kakao-sign-up"
    private var kakaoSiginInUrl = "\(Constant.BASE_URL)/app/kakao-sign-in"
    
    func requestFetchSignUp(_ parameters: SignUpRequest) {
        let url = "\(signUpUrl)"
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SignUpResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess) != nil {
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
    
    func requestFetchSignIn(_ parameters: SignInRequest) {
        let url = "\(signInUrl)"
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SignInResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if (response.isSuccess) != nil {
                        print("로그인에 성공하였습니다.")
                    } else {
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
}
