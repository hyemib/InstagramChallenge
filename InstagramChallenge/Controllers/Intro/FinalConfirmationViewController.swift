
import UIKit

class FinalConfirmationViewController: UIViewController {

    @IBOutlet weak var joinButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setJoinButtonDesign()
    }
    
    func setJoinButtonDesign() {
        joinButton.layer.cornerRadius = joinButton.frame.height / 5
    }
}
