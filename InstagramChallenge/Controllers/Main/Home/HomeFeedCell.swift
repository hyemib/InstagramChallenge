
import UIKit

class HomeFeedCell: UITableViewCell {

    @IBOutlet weak var feedProfileImage: UIImageView!
    @IBOutlet weak var feedImageCountView: UIView!
    @IBOutlet weak var feedImageCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        feedProfileImage.layer.cornerRadius = feedProfileImage.frame.height / 2
        feedImageCountView.layer.cornerRadius = feedImageCountView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
