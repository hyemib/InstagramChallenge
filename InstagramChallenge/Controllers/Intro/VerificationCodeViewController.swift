
import UIKit
import Firebase

class VerificationCodeViewController: UIViewController {

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var xButtonView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    var phoneNumber = ""
    var enableNextButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneNumberLabel.text = "\(phoneNumber)번으로 전송된 인증 코드를 입력하세요."
        xButtonView.isHidden = true
        
        verificationCodeTextField.addLeftPaading(padding: 10)
        setNextButtonDesign()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func clearTextFieldText(_ sender: UIButton) {
        verificationCodeTextField.text = ""
        setClearButton()
        setEnableNextButton()
    }
    
    func setNextButtonDesign() {
        setLoginOrJoinButtonDesign(button: nextButton)
    }
    
    @IBAction func movePhoneNumberOrEmailView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setClearButton() {
        if verificationCodeTextField.text?.count ?? 0 > 0 {
            xButtonView.isHidden = false
        } else {
            xButtonView.isHidden = true
        }
    }
    
    func setEnableNextButton() {
        if !isValidVertificationCode(code: verificationCodeTextField.text!) {
            nextButton.backgroundColor = .mainBlueBlurColor
            enableNextButton = false
        } else {
            nextButton.backgroundColor = .mainBlueColor
            enableNextButton = true
        }
    }
    
    @IBAction func setverificationCodeTextField(_ sender: Any) {
        checkTextFieldMaxLength(textField: verificationCodeTextField, maxLength: 6)
        setEnableNextButton()
        setClearButton()
    }
    
    func isValidVertificationCode(code: String?) -> Bool {
        guard code != nil else { return false }
        let codeRegEx = "[0-9]{6}"
        let pred = NSPredicate(format:"SELF MATCHES %@", codeRegEx)
        return pred.evaluate(with: code)
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        if !enableNextButton { return }
        if verificationCodeTextField.text! == "123456" {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "NameViewController") as? NameViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func moveJoinView(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
