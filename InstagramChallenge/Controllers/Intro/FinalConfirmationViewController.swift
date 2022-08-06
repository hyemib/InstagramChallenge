
import UIKit
import Alamofire

class FinalConfirmationViewController: UIViewController {

    @IBOutlet weak var loginId: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    
    private let authDataService = UserDataService()
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setJoinButtonDesign()
        loginId.text = "\(id)님으로 가입하시겠어요?"
        
        print(signUp)
        print(kakaoSignUp)
    }
    
    func setJoinButtonDesign() {
        joinButton.layer.cornerRadius = joinButton.frame.height / 5
    }
    
    func didSuccessJoin() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func completeJoin(_ sender: UIButton) {
        if kakaoSignUp.accessToken == "" {
            authDataService.requestFetchSignUp(signUp, delegate: self)
        } else {
            authDataService.requestFetchKakaoSignUp(kakaoSignUp, delegate: self)
        }
    }
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
