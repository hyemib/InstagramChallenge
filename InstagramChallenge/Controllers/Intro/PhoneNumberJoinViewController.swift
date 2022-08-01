
import UIKit
import FirebaseAuth
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser


class PhoneNumberJoinViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var xButtonView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    var enableNextButton = false
    var verifyID:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTextField.delegate = self
       
        xButtonView.isHidden = true
        
        phoneNumberTextField.addLeftPaading(padding: 105)
        setNextButtonDesign()
    }
    
    func checkTextFieldMaxLength(textField: UITextField!, maxLength: Int) {
        if textField.text?.count ?? 0 > maxLength {
            textField.deleteBackward()
        }
    }
    
    @IBAction func setPhoneNumberTextField_(_ sender: Any) {
        checkTextFieldMaxLength(textField: phoneNumberTextField, maxLength: 11)
        setEnableNextButton()
    }
    
    func setNextButtonDesign() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.backgroundColor = .mainBlueBlurColor
    }
    
    func setEnableNextButton() {
        if phoneNumberTextField.text!.isEmpty {
            nextButton.backgroundColor = .mainBlueBlurColor
            enableNextButton = false
            xButtonView.isHidden = true
        } else {
            nextButton.backgroundColor = .mainBlueColor
            enableNextButton = true
            xButtonView.isHidden = false
        }
    }
    
    @IBAction func clearTextFieldText(_ sender: UIButton) {
        phoneNumberTextField.text = ""
        setEnableNextButton()
    }
    
    func isValidPhoneNumber(phone: String?) -> Bool {
        guard phone != nil else { return false }
        let phoneRegEx = "[0-9]{11}"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: phone)
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        if !enableNextButton { return }
        if isValidPhoneNumber(phone: phoneNumberTextField.text!) {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "VerificationCodeViewController") as? VerificationCodeViewController else { return }
            vc.phoneNumber = phoneNumberTextField.text!
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func pressKakaoLoginButton(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(_, error) in
             if let error = error {
                 print(error)
             } else {
                 print("loginWithKakaoAccount() success.")

                 UserApi.shared.me {(user, error) in
                     if let error = error {
                         print(error)
                     } else {
                         UserDefaults.standard.set(user?.kakaoAccount?.email, forKey: "emailKey")
                         guard let vc = self.storyboard?.instantiateViewController(identifier: "PasswordViewController") as? PasswordViewController else { return }
                         vc.modalPresentationStyle = .fullScreen
                         self.present(vc, animated: false, completion: nil)
                     }
                 }
             }
        }
    }
}

