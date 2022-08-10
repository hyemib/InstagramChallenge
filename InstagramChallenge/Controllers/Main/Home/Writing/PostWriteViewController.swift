
import UIKit
import FirebaseStorage
import Kingfisher

class PostWriteViewController: UIViewController {
    
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var pharseTextView: UITextView!
    
    private let feedDataService = FeedDataService()
    var selectImage: UIImage?
    var imagesURLString = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectImageView.image = selectImage
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
                        print(error)
                        return
                    }
                    let urlString = url.absoluteString
                    self.imagesURLString.append(urlString)
                    print(self.imagesURLString)
                    self.feedDataService.requestFetchPostFeed(FeedRequest(feedText: self.pharseTextView.text!, contentsUrls: self.imagesURLString), delegate: self)
                }
            }
        }
        
        
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.tableView.reloadData()
        self.present(vc, animated: false, completion: nil)
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

extension PostWriteViewController: SendPharseDelegate {
    func send(pharse: String) {
        pharseTextView.text = pharse
        pharseTextView.font = .systemFont(ofSize: 16, weight: .regular)
        pharseTextView.textColor = .black
        
    }
}
