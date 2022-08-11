
import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var linkView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var storeView: UIView!
    @IBOutlet weak var removeView: UIView!
    
    private let feedDataService = FeedDataService()
    var feedInfo: FeedsResponseResult?
    
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
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PostUpdateViewController") as? PostUpdateViewController else { return }
        vc.feedInfo = feedInfo
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    
    func removeFeed() {
        feedDataService.requestFetchDeleteFeed(feedId: (feedInfo?.feedId)!, delegate: self)
        
    }
    
    @IBAction func removePostButotn(_ sender: UIButton) {
        guard let pvc = self.presentingViewController else { return }

        self.dismiss(animated: false) {
            let alert = UIAlertController(title:"", message: "이 게시물을 삭제하지 않으려면 게시물을 보관할 수 있습니다. 보관한 게시물은 회원님만 볼 수 있습니다.", preferredStyle: .actionSheet)
            let remove = UIAlertAction(title: "삭제", style: .destructive) { action in
                self.removeFeed()
            }
            let store = UIAlertAction(title: "보관", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(remove)
            alert.addAction(store)
            alert.addAction(cancel)
          
            pvc.present(alert, animated: false, completion: nil)
        }
    }
    
}
