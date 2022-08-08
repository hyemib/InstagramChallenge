
import UIKit
import Alamofire

extension UIViewController {
   
    func didSuccessLogin() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    func didFailKakaoLogin() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PhoneNumberOrEmailJoinViewController") as? PhoneNumberOrEmailJoinViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    func moveLoginView() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    func expireToken() {
        let alret = UIAlertController(title: "토큰 만료, 재로그인이 필요합니다.", message: "", preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default) {_ in
            self.moveLoginView()
        }
        alret.addAction(yes)
        self.present(alret, animated: true, completion: nil)
    }
}
