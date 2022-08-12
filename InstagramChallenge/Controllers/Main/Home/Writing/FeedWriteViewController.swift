
import UIKit
import FirebaseStorage
import Kingfisher

class FeedWriteViewController: UIViewController {
    
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var inputTextView: UITextView!
    
    private let feedDataService = FeedDataService()
    var selectImage: UIImage?
    var imagesURLString = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectImageView.image = selectImage
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DismissDetailView"), object: nil, userInfo: nil)
    }
    
    @IBAction func returnPhotoSelectView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func clickShareButton(_ sender: UIButton) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let storageRef = Storage.storage().reference().child("ena").child(Constant.myId).child("ena\(Int(Date().timeIntervalSince1970/1000.0))")
        let image = (self.selectImageView.image?.jpegData(compressionQuality: 1.0))!
        
        storageRef.putData(image, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!)
                return
            } else {
                storageRef.downloadURL{ (url, error) in
                    guard let url = url, error == nil else {
                        return
                    }
                    let urlString = url.absoluteString
                    self.imagesURLString.append(urlString)
                    print(self.imagesURLString)
                    self.feedDataService.requestFetchPostFeed(FeedRequest(feedText: self.inputTextView.text!, contentsUrls: self.imagesURLString), delegate: self)
                    self.view?.window?.rootViewController?.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
    
    @IBAction func inputContent(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "ContentViewController") as? ContentViewController else { return }
        vc.selectImage = selectImage
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
}

protocol SendPharseDelegate: AnyObject {
    func send(pharse: String)
}

extension FeedWriteViewController: SendPharseDelegate {
    func send(pharse: String) {
        inputTextView.text = pharse
        inputTextView.font = .systemFont(ofSize: 16, weight: .regular)
        inputTextView.textColor = .black
        
    }
}
