
import UIKit

class RemoveViewController: UIViewController {

    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var sentenceView: UIView!
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var cancelView: UIView!
    
    var feedIndex: Int?
    private let feedDataService = FeedDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        
        listView.layer.cornerRadius = 15
        sentenceView.layer.cornerRadius = 15
        sentenceView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        storeView.layer.cornerRadius = 15
        storeView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        cancelView.layer.cornerRadius = 15
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let y = touches.first?.location(in: self.view).y
        if y! < 288.0 {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func removePostButton(_ sender: UIButton) {
        feedDataService.requestFetchDeleteFeed(feedId: feedIndex!, delegate: self)
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
