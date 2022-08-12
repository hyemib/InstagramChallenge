
import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var feedLoginId: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var feedLoginId2: UILabel!
    @IBOutlet weak var feedText: UILabel!
    @IBOutlet weak var feedMoreText: UITextView!
    @IBOutlet weak var feedCommentCount: UILabel!
    @IBOutlet weak var feedCreatedAt: UILabel!
    
    var feedInfo: FeedsResponseResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFeedData()
        
        feedMoreText.textContainerInset = UIEdgeInsets(top: -20, left: -feedMoreText.textContainer.lineFragmentPadding, bottom: 0, right: -feedMoreText.textContainer.lineFragmentPadding)
    }
    
    func setFeedData() {
        feedLoginId.text = feedInfo?.feedLoginId
        feedLoginId2.text = feedInfo?.feedLoginId
        let imageUrl = URL(string: (feedInfo?.contentsList?[0].contentsUrl)!)
        feedImage.load(url: imageUrl!)
        var textArr = (feedInfo?.feedText)?.components(separatedBy: "\n")
        feedText.text = textArr?[0]
        textArr?.removeFirst()
        if textArr?.count ?? 0 >= 1 {
            feedMoreText.text = textArr?.joined(separator: "\n")
        }
        feedCommentCount.text = "\( feedInfo?.feedCommentCount! ?? 0)개"
        feedCreatedAt.text = setDate((feedInfo?.feedCreatedAt)!)
        
    }
    
    @IBAction func returnMyFeedView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
