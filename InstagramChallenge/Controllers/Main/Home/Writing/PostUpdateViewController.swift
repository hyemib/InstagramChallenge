
import UIKit

class PostUpdateViewController: UIViewController {

    @IBOutlet weak var personTagView: UIView!
    @IBOutlet weak var textUpdateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personTagView.layer.cornerRadius = personTagView.frame.height / 2
        textUpdateView.layer.cornerRadius = textUpdateView.frame.height / 2

    }
    
    @IBAction func returnView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func completeUpdateButton(_ sender: Any) {
    
    }
    

}
