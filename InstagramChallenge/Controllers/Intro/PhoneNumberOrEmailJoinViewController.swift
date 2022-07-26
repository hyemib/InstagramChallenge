
import UIKit

class PhoneNumberOrEmailJoinViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var phoneNumberBar: UIView!
    @IBOutlet weak var emailBar: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeViewToPhoneNumberView()
        emailBar.isHidden = true
    }
    
    @IBAction func selectPhoneNumberTabBar(_ sender: UIButton) {
        changeViewToPhoneNumberView()
        phoneNumberBar.isHidden = false
        emailBar.isHidden = true
    }
    
    @IBAction func selectEmailTabBar(_ sender: UIButton) {
        changeViewToEmailView()
        emailBar.isHidden = false
        phoneNumberBar.isHidden = true
    }
    
    func changeViewToPhoneNumberView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PhoneNumberJoinViewController")
        self.addChild(vc)
        containerView.addSubview((vc.view)!)
        vc.view.frame = containerView.bounds
        vc.didMove(toParent: self)
    }
    
    
    func changeViewToEmailView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EmailJoinViewController")
        self.addChild(vc)
        containerView.addSubview((vc.view)!)
        vc.view.frame = containerView.bounds
        vc.didMove(toParent: self)
    }
    
}
