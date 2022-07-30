
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
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PasswordViewController") as? PasswordViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
