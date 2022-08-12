
import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var chatContent: UILabel!
    
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        setChatViewDesign()
        
        chatContent.text = content
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func setChatViewDesign() {
        chatView.layer.borderWidth = 1
        chatView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        chatView.layer.cornerRadius = 10
    }
    
}

