
import UIKit

class NameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var xButtonView: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var enableNextButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        
        nameTextField.addLeftPaading(padding: 10)
        setNextButtonDesign()
        
        xButtonView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    func setNextButtonDesign() {
        setLoginOrJoinButtonDesign(button: nextButton)
    }
    
    func setEnableNextButton() {
        if nameTextField.text!.isEmpty {
            nextButton.backgroundColor = .mainBlueBlurColor
            enableNextButton = false
            xButtonView.isHidden = true
        } else {
            nextButton.backgroundColor = .mainBlueColor
            enableNextButton = true
            xButtonView.isHidden = false
        }
    }
    
    @IBAction func setNameTextField_(_ sender: Any) {
        checkTextFieldMaxLength(textField: nameTextField, maxLength: 20)
        setEnableNextButton()
    }
    
    @IBAction func clearTextFieldText(_ sender: UIButton) {
        nameTextField.text = ""
        setEnableNextButton()
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        if !enableNextButton { return }
        signUp.realName = nameTextField.text!
        kakaoSignUp.realName = nameTextField.text!
        
        if kakaoSignUp.accessToken == "" {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "PasswordViewController") as? PasswordViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        } else {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "BirthdayViewController") as? BirthdayViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        moveLoginView()
    }
}
