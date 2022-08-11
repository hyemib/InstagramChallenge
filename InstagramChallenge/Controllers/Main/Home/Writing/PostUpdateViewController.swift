
import UIKit

class PostUpdateViewController: UIViewController, UITextViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var personTagView: UIView!
    @IBOutlet weak var textUpdateView: UIView!
    
    @IBOutlet weak var feedLoginId: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedText: UITextView!
    @IBOutlet weak var feedTextViewBottom: NSLayoutConstraint!
    
    private let feedDataService = FeedDataService()
    var feedInfo: FeedsResponseResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personTagView.layer.cornerRadius = personTagView.frame.height / 2
        textUpdateView.layer.cornerRadius = textUpdateView.frame.height / 2
        feedText.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setFeedData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
    }
   
    
    func setFeedData() {
        feedLoginId.text = feedInfo?.feedLoginId
        let imageUrl = URL(string: (feedInfo?.contentsList?[0].contentsUrl)!)
        feedImage.load(url: imageUrl!)
        feedText.text = feedInfo?.feedText
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let height = keyboardFrame.size.height + self.view.safeAreaInsets.bottom
        
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) { [self] in
            self.feedTextViewBottom.constant
            = height
            self.view.layoutIfNeeded()
            
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height-scrollView.bounds.height), animated: true)
        }
    }
        
        
    
    @objc func keyboardWillHide(noti: Notification) {

        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.feedTextViewBottom.constant = 20
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func returnView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func completeUpdateFeed(_ sender: UIButton) {
        feedDataService.requestFetchUpdateFeed(FeedsRequest(feedText: feedText.text!), feedId: (feedInfo?.feedId)!, delegate: self)
    }
    

}
