
import UIKit

class PhoneNumberJoinViewController: UIViewController {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTextField.addLeftPaading(padding: 105)
        setNextButtonDesign()
        setTextField()
    }
    
    func setTextField() {
        self.phoneNumberTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
    
    @objc func didChangeTextField(_ sender: Any?) {
        if phoneNumberTextField.text!.isEmpty {
            nextButton.backgroundColor = .mainBlueBlurColor
        } else {
            nextButton.backgroundColor = .mainBlueColor
        }
    }
    
    func setNextButtonDesign() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.backgroundColor = .mainBlueBlurColor
    }

}
