
import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentId: UILabel!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var createdAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
