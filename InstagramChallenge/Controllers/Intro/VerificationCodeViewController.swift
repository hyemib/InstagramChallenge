
import UIKit

class VerificationCodeViewController: UIViewController {

    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        verificationCodeTextField.addLeftPaading(padding: 10)
        setNextButtonDesign()
        setTextField()
    }
    
    func setNextButtonDesign() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.backgroundColor = .mainBlueBlurColor
    }
    
    func setTextField() {
        self.verificationCodeTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
    
    @objc func didChangeTextField(_ sender: Any?) {
        if verificationCodeTextField.text!.isEmpty {
            nextButton.backgroundColor = .mainBlueBlurColor
        } else {
            nextButton.backgroundColor = .mainBlueColor
        }
    }

}
