
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class JoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressKakaoLoginButton(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
             if let error = error {
                 print(error)
             } else {
                 print("loginWithKakaoAccount() success.")

                 UserApi.shared.me {(user, error) in
                     if let error = error {
                         print(error)
                     } else {
                         UserDefaults.standard.set(oauthToken?.accessToken, forKey: "kakaoToken")
                         guard let vc = self.storyboard?.instantiateViewController(identifier: "PhoneNumberJoinViewController") as? PhoneNumberJoinViewController else { return }
                         vc.modalPresentationStyle = .fullScreen
                         self.present(vc, animated: false, completion: nil)
                     }
                 }
             }
        }
    }
    
    
    @IBAction func movePhoneNumberOrEmailJoin(_ sender: UIButton) {
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

