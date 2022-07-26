
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordViewButtonImgae: UIImageView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var isPasswordView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldDesign()
        setLoginButtonDesign()
        
        setTextField()
    }
    
    func setTextFieldDesign() {
        idTextField.addLeftPaading(padding: 10)
        passwordTextField.addLeftPaading(padding: 10)
    }
    
    func setTextField() {
        passwordTextField.isSecureTextEntry = isPasswordView
        self.passwordTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
    
    @objc func didChangeTextField(_ sender: Any?) {
        if passwordTextField.text!.isEmpty {
            loginButton.backgroundColor = .mainBlueBlurColor
        } else {
            loginButton.backgroundColor = .mainBlueColor
        }
    }
    
    @IBAction func changePasswordView(_ sender: Any) {
        if isPasswordView {
            passwordTextField.isSecureTextEntry = false
            passwordViewButtonImgae.image = UIImage(named: "password_view_true")
        } else {
            passwordTextField.isSecureTextEntry = true
            passwordViewButtonImgae.image = UIImage(named: "password_view_false")
        }
        isPasswordView = !isPasswordView
    }
    
    
    func setLoginButtonDesign() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 5
        loginButton.backgroundColor = .mainBlueBlurColor
    }
    
    @IBAction func moveJoinButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "JoinViewController") as? JoinViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}

