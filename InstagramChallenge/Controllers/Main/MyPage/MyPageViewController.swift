
import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var myFeedBar: UIView!
    @IBOutlet weak var myFeedImage: UIImageView!
    
    @IBOutlet weak var TagBar: UIView!
    @IBOutlet weak var tagImage: UIImageView!
    
    @IBOutlet weak var loginId: UILabel!
    @IBOutlet var realName: UILabel!
    @IBOutlet weak var feedCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    private let userDataService = UserDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeViewToMyFeedView()
        TagBar.isHidden = true
        
        userDataService.requestFetchMyPage(loginId: Constant.myId, delegate: self)
    }
    
    func setMyPageView(result: MyPageResponseResult) {
        loginId.text = result.loginId
        realName.text = result.realName
        followerCount.text = "\(String(describing: (result.followerCount)!))"
        followingCount.text = "\(String(describing: (result.followingCount)!))"
        feedCount.text = "\(String(describing: (result.feedCount)!))"
    }
    
    @IBAction func goToCreatePost(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PhotoSelectViewController") as? PhotoSelectViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func selectMyFeedBarTabBar(_ sender: UIButton) {
        changeViewToMyFeedView()
        myFeedBar.isHidden = false
        TagBar.isHidden = true
        myFeedImage.image = UIImage(named: "myfeed_true")
        tagImage.image = UIImage(named: "tag_false")
    }
    
    @IBAction func selectTagTabBar(_ sender: UIButton) {
        changeViewToTagView()
        TagBar.isHidden = false
        myFeedBar.isHidden = true
        myFeedImage.image = UIImage(named: "myfeed_false")
        tagImage.image = UIImage(named: "tag_true")
    }
    
    func changeViewToMyFeedView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyFeedViewController")
        self.addChild(vc)
        containerView.addSubview((vc.view)!)
        vc.view.frame = containerView.bounds
        vc.didMove(toParent: self)
    }
    
    
    func changeViewToTagView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TagViewController")
        self.addChild(vc)
        containerView.addSubview((vc.view)!)
        vc.view.frame = containerView.bounds
        vc.didMove(toParent: self)
    }
}

