
import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var xButtonView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    var enableNextButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        
        passwordTextField.addLeftPaading(padding: 10)
        passwordTextField.isSecureTextEntry = true
        
        xButtonView.isHidden = true
        
        setNextButtonDesign()
    }
    
    func setNextButtonDesign() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.backgroundColor = .mainBlueBlurColor
    }
    
    func checkTextFieldMaxLength(textField: UITextField!, maxLength: Int) {
        if textField.text?.count ?? 0 > maxLength {
            textField.deleteBackward()
        }
    }
    
    func setEnableNextButton() {
        if passwordTextField.text!.isEmpty {
            nextButton.backgroundColor = .mainBlueBlurColor
            enableNextButton = false
            xButtonView.isHidden = true
        } else {
            nextButton.backgroundColor = .mainBlueColor
            enableNextButton = true
            xButtonView.isHidden = false
        }
    }
    
    @IBAction func setPasswordTextField_(_ sender: Any) {
        checkTextFieldMaxLength(textField: passwordTextField, maxLength: 20)
        setEnableNextButton()
    }

    @IBAction func clearTextFieldText(_ sender: UIButton) {
        passwordTextField.text = ""
        setEnableNextButton()
    }
    
    func isValidLogin(textField: UITextField!, minLength: Int, maxLength: Int) -> Bool {
        guard textField.text != nil else { return false }
        
        let regEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{\(minLength),\(maxLength)}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: textField.text)
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        if !enableNextButton { return }
        
        if isValidLogin(textField: passwordTextField, minLength: 6, maxLength: 20) {
            UserDefaults.standard.set(passwordTextField.text!, forKey: "passwordKey")
            guard let vc = self.storyboard?.instantiateViewController(identifier: "BirthdayViewController") as? BirthdayViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        } else {
            let alret = UIAlertController(title: "비밀번호를 확인해주세요", message: "", preferredStyle: .alert)
            let yes = UIAlertAction(title: "확인", style: .default)
            alret.addAction(yes)
            present(alret, animated: true, completion: nil)
        }
    }
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
