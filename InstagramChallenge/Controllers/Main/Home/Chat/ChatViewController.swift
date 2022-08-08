
import UIKit

class ChatViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var inputTextViewBottom: NSLayoutConstraint!
    @IBOutlet weak var inputTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var sendButton: UIButton!
    
    private let chatDataService = ChatDataService()
    var chatInfo: [ChatsResponseResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        inputTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        inputTextView.layer.borderWidth = 1
        inputTextView.layer.cornerRadius = inputTextView.frame.height / 2
        inputTextView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        
        inputTextView.textContainerInset = UIEdgeInsets(top: 12, left: 47, bottom: 12, right: 10)
        
        sendButton.isHidden = true
        
        chatDataService.requestFetchGetChat(pageIndex: 0, size: 10, delegate: self)
    }
    
    func didSuccessGetChatData(result: [ChatsResponseResult]) {
        chatInfo = result
        chatInfo?.reverse()
        tableView.reloadData()
    }
    
    func checkTextViewMaxLength(textView: UITextView!, maxLength: Int) {
        if textView.text?.count ?? 0 > maxLength {
            textView.deleteBackward()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height <= 40 {
            inputTextViewHeight.constant = 40
        } else if textView.contentSize.height >= 120 {
            inputTextViewHeight.constant = 120
        } else {
            inputTextViewHeight.constant = textView.contentSize.height
        }
        checkTextViewMaxLength(textView: inputTextView, maxLength: 200)
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        inputTextView.text = ""
        imagesStackView.isHidden = true
        sendButton.isHidden = false
        inputTextView.textColor = .black
        
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            self.inputTextViewBottom.constant = height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(noti: Notification) {
        inputTextView.text = "메시지 보내기..."
        imagesStackView.isHidden = false
        sendButton.isHidden = true
        inputTextView.textColor = .mainLightGrayColor
        
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.inputTextViewBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func returnHomeView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        let lastIndexPath = IndexPath(row: 0, section: 0)
        
        //tableView.insertRows(at: [lastIndexPath], with: UITableView.RowAnimation.automatic)
        
        tableView.scrollToRow(at: lastIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        inputTextViewHeight.constant = 40
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let yourCell = tableView.dequeueReusableCell(withIdentifier: "YourMessageCell", for: indexPath) as! YourMessageCell
        yourCell.selectionStyle = .none
        yourCell.yourMessage.text = chatInfo?[indexPath.row].content
        yourCell.date.text = chatInfo?[indexPath.row].updatedAt
        return yourCell*/
        let yourCell = tableView.dequeueReusableCell(withIdentifier: "YourMessageCell", for: indexPath) as! YourMessageCell
        yourCell.selectionStyle = .none
        yourCell.yourMessage.text = chatInfo?[indexPath.row].content
        yourCell.date.isHidden = true
      
        //yourCell.date.text = chatInfo?[indexPath.row].updatedAt
        return yourCell
        
        
    }
}



