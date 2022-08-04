
import UIKit

class WritingViewController: UIViewController {
    
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var pharseTextView: UITextView!
    
    var selectImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectImageView.image = selectImage
    }

    @IBAction func returnPhotoSelectView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func clickShareButton(_ sender: UIButton) {
        
    }
    
    @IBAction func enterAParse(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PhraseViewController") as? PhraseViewController else { return }
        vc.selectImage = selectImage
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
}

protocol SendPharseDelegate: AnyObject {
    func send(pharse: String)
}

extension WritingViewController: SendPharseDelegate {
    func send(pharse: String) {
        pharseTextView.text = pharse
        pharseTextView.font = .systemFont(ofSize: 16, weight: .regular)
        pharseTextView.textColor = .black
        
    }
}
