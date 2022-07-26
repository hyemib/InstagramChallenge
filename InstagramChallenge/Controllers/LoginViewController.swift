
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
        idTextField.addLeftPaading()
        passwordTextField.addLeftPaading()
    }
    
    func setTextField() {
        passwordTextField.isSecureTextEntry = isPasswordView
        self.passwordTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
    
    @objc func didChangeTextField(_ sender: Any?) {
        if passwordTextField.text!.isEmpty {
            loginButton.backgroundColor = UIColor(red: 65/255, green: 146/255, blue: 236/255, alpha: 0.5)
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
        loginButton.backgroundColor = UIColor(red: 65/255, green: 146/255, blue: 236/255, alpha: 0.5)
    }

}

