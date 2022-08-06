
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import Firebase

class JoinViewController: UIViewController {

    private let userDataService = UserDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressKakaoLoginButton(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
             if let _ = error {
                 let alret = UIAlertController(title: "로그인에 실패하였습다.", message: "", preferredStyle: .alert)
                 let yes = UIAlertAction(title: "확인", style: .default)
                 alret.addAction(yes)
                 self.present(alret, animated: true, completion: nil)
             } else {
                 UserApi.shared.me {(user, error) in
                     if let _ = error {
                         let alret = UIAlertController(title: "로그인에 실패하였습다.", message: "", preferredStyle: .alert)
                         let yes = UIAlertAction(title: "확인", style: .default)
                         alret.addAction(yes)
                         self.present(alret, animated: true, completion: nil)
                     } else {
                         self.userDataService.requestFetchKakaoSignIn(KakaoSignInRequest(accessToken: oauthToken!.accessToken), delegate: self)
                         kakaoSignUp.accessToken = oauthToken!.accessToken
                     }
                 }
             }
        }
    }
    
    @IBAction func movePhoneNumberOrEmailJoinView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PhoneNumberOrEmailJoinViewController") as? PhoneNumberOrEmailJoinViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}

