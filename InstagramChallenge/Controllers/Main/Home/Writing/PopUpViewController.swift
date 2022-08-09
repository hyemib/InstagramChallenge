
import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var linkView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var removeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)

        popUpView.layer.cornerRadius = 20
        popUpView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        shareView.layer.cornerRadius = 15
        linkView.layer.cornerRadius = 15
        listView.layer.cornerRadius = 15
        storeView.layer.cornerRadius = 15
        storeView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        removeView.layer.cornerRadius = 15
        removeView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let y = touches.first?.location(in: self.view).y
        if y! < 288.0 {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func updatePostButton(_ sender: UIButton) {
    }
    
    @IBAction func removePostButotn(_ sender: UIButton) {
    }
    
}
