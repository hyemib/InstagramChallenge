
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
    
    @IBAction func completeJoin(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func moveLoginView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
