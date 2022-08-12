
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
                 self.presentFailKakaoLoginAlert()
             } else {
                 UserApi.shared.me {(user, error) in
                     if let _ = error {
                         self.presentFailKakaoLoginAlert()
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
        moveLoginView()
    }
}

