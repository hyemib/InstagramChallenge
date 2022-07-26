
import UIKit

class JoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func movePhoneNumberOrEmailJoinButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PhoneNumberOrEmailJoinViewController") as? PhoneNumberOrEmailJoinViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}

