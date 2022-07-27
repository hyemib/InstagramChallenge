
import UIKit

class UserNameViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.addLeftPaading(padding: 10)
        setNextButtonDesign()
    }
    
    func setNextButtonDesign() {
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
    }
}
