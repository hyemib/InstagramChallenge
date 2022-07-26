
import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.addLeftPaading(padding: 10)
        setTextField()
        setNextButtonDesign()
    }
    
    func setNextButtonDesign() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.backgroundColor = .mainBlueBlurColor
    }
    
    func setTextField() {
        self.passwordTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
    
    @objc func didChangeTextField(_ sender: Any?) {
        if passwordTextField.text!.isEmpty {
            nextButton.backgroundColor = .mainBlueBlurColor
        } else {
            nextButton.backgroundColor = .mainBlueColor
        }
    }

    @IBAction func removeTextFieldText(_ sender: UIButton) {
        passwordTextField.text = ""
    }
}
