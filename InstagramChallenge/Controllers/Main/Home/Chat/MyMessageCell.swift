
import UIKit

class MyMessageCell: UITableViewCell {

    @IBOutlet weak var myMessageView: UIView!
    @IBOutlet weak var myMessage: UITextView!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var myMessageTop: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myMessageView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
