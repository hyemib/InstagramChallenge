
import UIKit

class AlbumCell: UICollectionViewCell {
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var selectView: UIView!
    
   override func awakeFromNib() {
       super.awakeFromNib()
       self.albumImage.contentMode = .scaleAspectFill
   }
   
   override func prepareForReuse() {
       super.prepareForReuse()
   }
}


