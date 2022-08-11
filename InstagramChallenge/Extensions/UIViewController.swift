
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
    
    func setDate(_ dateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let date = dateFormatter.date(from: dateString)
        let offsetComps = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: date!, to: Date())
        if case let (m?, d?, h?, mm?) = (offsetComps.month, offsetComps.day, offsetComps.hour, offsetComps.minute) {
            if m >= 1 {
                return "\(m)월 \(d)일 전"
            } else if d >= 1 {
                return "\(d)일 전"
            } else if h+8 >= 1 {
                return "\(h+8)시간 전"
            } else {
                return "\(60+mm)분 전"
            }
        }
        return ""
    }
   
}
