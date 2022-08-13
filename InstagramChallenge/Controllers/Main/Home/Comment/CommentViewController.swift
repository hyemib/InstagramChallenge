
import UIKit

class CommentViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var inputTextViewBottom: NSLayoutConstraint!
    @IBOutlet weak var completButton: UIButton!
    
    private let feedDataService = FeedDataService()
    var feedIndex: Int?
    var currentPage = 0
    var contents: CommentContents?
    var commentInfo = [CommentResponseResult]()
    var fetchMore = false
    var enableButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        inputTextView.delegate = self
        
        feedDataService.requestFetchGetComment(feedId: feedIndex!, pageIndex: currentPage, size: 10, delegate: self)
        
        completButton.tintColor = .mainBlueBlurColor
        
        setInputTextViewDesign()
      
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    func setGetCommentData(result: [CommentResponseResult]) {
        commentInfo.append(contentsOf: result)
        tableView.reloadData()
    }
    
    func setInputTextViewDesign() {
        inputTextView.layer.borderWidth = 1
        inputTextView.layer.cornerRadius = inputTextView.frame.height / 2
        inputTextView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        
        inputTextView.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 13, right: 10)
    }
    
    @IBAction func returnHomeView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func beginBatchFetch() {
        fetchMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.currentPage += 1
            
            self.feedDataService.requestFetchGetComment(feedId: self.feedIndex!, pageIndex: self.currentPage, size: 10, delegate: self)
            self.tableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y > (tableView.contentSize.height - tableView.bounds.size.height) {
            if !fetchMore {
                beginBatchFetch()
            }
        }
    }
    
    func checkTextViewMaxLength(textView: UITextView!, maxLength: Int) {
        if textView.text?.count ?? 0 > maxLength {
            textView.deleteBackward()
        }
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        inputTextView.text = ""
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
        inputTextView.text = "댓글 달기..."
        inputTextView.textColor = .mainLightGrayColor

        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDuration) {
            self.inputTextViewBottom.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleTextDidChange() {
        checkTextViewMaxLength(textView: inputTextView, maxLength: 200)
        if inputTextView.text.count > 0 {
            enableButton = true
            completButton.tintColor = .mainBlueColor
        } else {
            enableButton = false
            completButton.tintColor = .mainBlueBlurColor
        }
    }
    
    @IBAction func completeCommentButton(_ sender: UIButton) {
        if !enableButton { return }
        feedDataService.requestFetchPostComment(CommentRequest(commentText: inputTextView.text!), feedId: feedIndex!, delegate: self)
        self.view.endEditing(true)
        
    }
    
    func didSuccessAddComment() {
        commentInfo = []
        feedDataService.requestFetchGetComment(feedId: feedIndex!, pageIndex: 0, size: 10, delegate: self)
    }
    
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return commentInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentsCell", for: indexPath) as! ContentsCell
            cell.feedLoginId.text = contents?.feedLoginId
            var textArr = contents?.feedText.components(separatedBy: "\n")
            cell.feedText.text = textArr?[0]
            textArr?.removeFirst()
            if textArr?.count ?? 0 >= 1 {
                cell.feedMoreText.text = textArr?.joined(separator: "\n")
            }
            cell.feedCreatedAt.text = setDate(contents!.feedCreatedAt)
            return cell
        }
       let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.commentId.text = commentInfo[indexPath.row].loginId
        
        var textArr = commentInfo[indexPath.row].commentText?.components(separatedBy: "\n")
        cell.commentText.text = textArr?[0]
        textArr?.removeFirst()
        if textArr?.count ?? 0 >= 1 {
            cell.commentMoreText.text = textArr?.joined(separator: "\n")
        }
        cell.createdAt.text = (setDate(commentInfo[indexPath.row].createdAt!))
        return cell
    }
    
    
}
