
import UIKit
import Alamofire

class FinalConfirmationViewController: UIViewController {

    @IBOutlet weak var joinButton: UIButton!
    
    private let authDataService = UserDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setJoinButtonDesign()
    }
    
    func setJoinButtonDesign() {
        joinButton.layer.cornerRadius = joinButton.frame.height / 5
    }
    
    @IBAction func completeJoin(_ sender: UIButton) {
        if kakaoSignUp.accessToken == "" {
            authDataService.requestFetchSignUp(signUp)
        } else {
            authDataService.requestFetchKakaoSignUp(kakaoSignUp)
        }
        
       /*
        Auth.auth().createUser(withEmail: userName, password: password) { authData, error in
            if let error = error {
                print(error)
                return
            }
            //let uid = authData?.user.uid
            Database.database().reference().child("users").child(userName).setValue(["name":name, "birthday":birthday, "phoneNumber": phoneNumber])
            Auth.auth().signIn(withEmail: userName, password: password, completion: nil)
            guard let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
            
        }*/
    }
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
