
import UIKit

class ContentsCell: UITableViewCell {

    @IBOutlet weak var feedLoginId: UILabel!
    @IBOutlet weak var feedText: UILabel!
    @IBOutlet weak var feedMoreText: UITextView!
    @IBOutlet weak var feedCreatedAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        feedMoreText.textContainerInset = UIEdgeInsets(top: -20, left: -feedMoreText.textContainer.lineFragmentPadding, bottom: 0, right: -feedMoreText.textContainer.lineFragmentPadding)
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
