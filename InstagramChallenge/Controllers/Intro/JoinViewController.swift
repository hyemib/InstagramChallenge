
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import Firebase

class JoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressKakaoLoginButton(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
             if let error = error {
                 print(error)
                 let alret = UIAlertController(title: "로그인에 실패하였습다.", message: "", preferredStyle: .alert)
                 let yes = UIAlertAction(title: "확인", style: .default)
                 alret.addAction(yes)
                 self.present(alret, animated: true, completion: nil)
             } else {
                 print("loginWithKakaoAccount() success.")
                 UserApi.shared.me {(user, error) in
                     if let error = error {
                         print(error)
                     } else {
                         /*
                         Auth.auth().signIn(withEmail: "\(String(describing: user?.kakaoAccount?.email))", password: "\(String(describing: user?.id))") { result, error in
                             if let error = error {
                                 print(error)
                                 UserDefaults.standard.set(user?.kakaoAccount?.email, forKey: "emailKey")
                                 UserDefaults.standard.set("\(String(describing: user?.id))", forKey: "passwordKey")
                                 kakaoJoin = true
                                 
                                 guard let vc = self.storyboard?.instantiateViewController(identifier: "PhoneNumberOrEmailJoinViewController") as? PhoneNumberOrEmailJoinViewController else { return }
                                 vc.modalPresentationStyle = .fullScreen
                                 self.present(vc, animated: false, completion: nil)
                                 return
                             }
                             guard let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
                             vc.modalPresentationStyle = .fullScreen
                             self.present(vc, animated: false, completion: nil)
                         }*/
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

