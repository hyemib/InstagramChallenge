
import UIKit

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
    
    func expireToken() {
        
    }
}
