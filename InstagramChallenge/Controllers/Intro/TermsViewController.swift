
import UIKit

class TermsViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setContinueButtonDesign()
    }
    
    func setContinueButtonDesign() {
        continueButton.layer.cornerRadius = continueButton.frame.height / 5
    }
}
