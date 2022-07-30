
import UIKit

class VerificationCodeViewController: UIViewController {

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var xButtonView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    var phoneNumber = ""
    var enableNextButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // phoneNumberLabel.text = "+82\(phoneNumber.suffix(phoneNumber.count-1))번으로 전송된 인증 코드를 입력하세요."
        xButtonView.isHidden = true
        
        verificationCodeTextField.addLeftPaading(padding: 10)
        setNextButtonDesign()
    }
    
    @IBAction func clearTextFieldText(_ sender: UIButton) {
        verificationCodeTextField.text = ""
        setEnableNextButton()
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
        if !isValidVertificationCode(code: verificationCodeTextField.text!) {
            nextButton.backgroundColor = .mainBlueBlurColor
            enableNextButton = false
            xButtonView.isHidden = true
        } else {
            nextButton.backgroundColor = .mainBlueColor
            enableNextButton = true
            xButtonView.isHidden = false
        }
    }
    
    @IBAction func setverificationCodeTextField(_ sender: Any) {
        checkTextFieldMaxLength(textField: verificationCodeTextField, maxLength: 6)
        setEnableNextButton()
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
