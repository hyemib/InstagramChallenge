
import UIKit

class UserNameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.delegate = self
        
        userNameTextField.addLeftPaading(padding: 10)
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
    
    @IBAction func setUserNameTextField_(_ sender: Any) {
        checkTextFieldMaxLength(textField: userNameTextField, maxLength: 20)
    }
    
    @IBAction func clearTextFieldText(_ sender: UIButton) {
        userNameTextField.text = ""
    }
    
    func isValidUserName(textField: UITextField!) -> Bool {
        guard textField.text != nil else { return false }
        let regEx = "[A-Za-z0-9]"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: textField.text)
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        // 중복된 경우
        /*
        let alret = UIAlertController(title: "\(userNameTextField.text!)을(를) 사용할 수 없습니다.", message: "", preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default)
        alret.addAction(yes)
        present(alret, animated: true, completion: nil)
        */
        guard let vc = self.storyboard?.instantiateViewController(identifier: "FinalConfirmationViewController") as? FinalConfirmationViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
