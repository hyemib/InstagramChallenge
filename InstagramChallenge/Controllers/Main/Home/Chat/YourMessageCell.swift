
import UIKit

class YourMessageCell: UITableViewCell {

    @IBOutlet weak var yourMessageView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var yourMessage: UITextView!
    @IBOutlet weak var yourMessageTop: NSLayoutConstraint!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        yourMessageView.layer.borderWidth = 1
        yourMessageView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        yourMessageView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
