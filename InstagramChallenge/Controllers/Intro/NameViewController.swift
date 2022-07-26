
import UIKit

class NameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.addLeftPaading(padding: 10)
        setTextField()
        setNextButtonDesign()
    }
    
    func setNextButtonDesign() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.backgroundColor = .mainBlueBlurColor
    }
    
    func setTextField() {
        self.nameTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
    
    @objc func didChangeTextField(_ sender: Any?) {
        if nameTextField.text!.isEmpty {
            nextButton.backgroundColor = .mainBlueBlurColor
        } else {
            nextButton.backgroundColor = .mainBlueColor
        }
    }

}
