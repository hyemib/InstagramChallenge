
import UIKit

class HomeFeedCell: UITableViewCell {

    @IBOutlet weak var feedProfileImage: UIImageView!
    @IBOutlet weak var feedImageCountView: UIView!
    @IBOutlet weak var feedImageCount: UILabel!
    @IBOutlet weak var feedLoginId: UILabel!
    @IBOutlet weak var feedLoginId2: UILabel!
    @IBOutlet weak var feedText: UILabel!
    @IBOutlet weak var feedMoreText: UITextView!
    @IBOutlet weak var feedCreatedAt: UILabel!
    @IBOutlet weak var feedCommentCount: UILabel!
    @IBOutlet weak var feedContets: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!

    var delegate: SendHomeDelegate?
    var index: Int?
    var feedId: String?
    var feedIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        feedProfileImage.layer.cornerRadius = feedProfileImage.frame.height / 2
        feedImageCountView.layer.cornerRadius = feedImageCountView.frame.height / 2
        
        feedMoreText.textContainerInset = UIEdgeInsets(top: -20, left: -feedMoreText.textContainer.lineFragmentPadding, bottom: 0, right: -feedMoreText.textContainer.lineFragmentPadding)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func clickCommentButton(_ sender: UIButton) {
        guard let idx = index else { return }
        delegate?.moveCommentView(index: idx, pharse: feedText.text!, feedIndex: feedIndex!)
    }
    
    @IBAction func clickMoreButton(_ sender: UIButton) {
        guard let idx = index else { return }
        if feedId == Constant.myId {
            delegate?.movePopupView(index: idx, feedIndex: feedIndex!)
        }
    }
}

protocol SendHomeDelegate: AnyObject {
    func moveCommentView(index: Int, pharse: String, feedIndex: Int)
    func movePopupView(index: Int, feedIndex: Int)
}
