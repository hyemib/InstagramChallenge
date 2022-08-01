
import UIKit
import Firebase
import FirebaseAuth

class FinalConfirmationViewController: UIViewController {

    @IBOutlet weak var joinButton: UIButton!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setJoinButtonDesign()
    }
    
    func setJoinButtonDesign() {
        joinButton.layer.cornerRadius = joinButton.frame.height / 5
    }
    
    @IBAction func completeJoin(_ sender: UIButton) {
        guard let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumberKey") else { return print("Something Wierd") }
        guard let name = UserDefaults.standard.string(forKey: "nameKey") else { return print("Something Wierd") }
        guard let userName = UserDefaults.standard.string(forKey: "userNameKey") else { return print("Something Wierd") }
        guard let birthday = UserDefaults.standard.string(forKey: "birthdayKey") else { return print("Something Wierd") }
        
        let verificationCode = "123456"
       
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print(error)
                return
            }
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "", verificationCode: verificationCode)
            Auth.auth().signIn(with: credential, completion: { authData, error in
                if let error = error {
                    print(error)
                    return
                }
                let uid = authData?.user.uid
                Database.database().reference().child("users").child(uid!).setValue(["name":name, "userName":userName, "birthday":birthday])
                guard let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            })
        }
    }
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
