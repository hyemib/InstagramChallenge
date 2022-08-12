
import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var pharseTextView: UITextView!
    
    var selectImage: UIImage?
    weak var delegate: SendPharseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        pharseTextView.delegate = self
        
        selectImageView.image = selectImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pharseTextView.becomeFirstResponder()
    }
    
    @IBAction func clickConfirmationButton(_ sender: UIButton) {
        self.delegate?.send(pharse: pharseTextView.text)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension ContentViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = pharseTextView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count < 1000
    }
}
