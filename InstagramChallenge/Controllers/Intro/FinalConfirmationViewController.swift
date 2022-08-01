
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
        guard let email = UserDefaults.standard.string(forKey: "emailKey") else { return print("Something Wierd") }
        guard let password = UserDefaults.standard.string(forKey: "passwordKey") else { return print("Something Wierd") }
        guard let userName = UserDefaults.standard.string(forKey: "userNameKey") else { return print("Something Wierd") }
        guard let birthday = UserDefaults.standard.string(forKey: "birthdayKey") else { return print("Something Wierd") }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            let uid = result?.user.uid
            Database.database().reference().child("users").child(uid!).setValue(["name":userName, "birthday":birthday])
        }
        guard let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
