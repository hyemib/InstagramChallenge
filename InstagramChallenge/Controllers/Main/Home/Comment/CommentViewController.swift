
import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var feedPharse: UITextView!
    
    private let feedDataService = FeedDataService()
    var pharse = ""
    var feedIndex: Int?
    var currentPage = 0
    var commentInfo = [CommentResponseResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        feedPharse.text = pharse
        
        feedDataService.requestFetchGetComment(feedId: feedIndex!, pageIndex: currentPage, size: 1, delegate: self)
        
        //feedView.frame =  CGRect(x: 0, y: 0, width: tableView.frame.width, height: feedPharse.frame.height)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    func setGetCommentData(result: [CommentResponseResult]) {
        commentInfo.append(contentsOf: result)
        tableView.reloadData()
    }
    
    
    @IBAction func returnHomeView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func completeCommentButton(_ sender: UIButton) {
        feedDataService.requestFetchPostComment(<#T##parameters: CommentRequest##CommentRequest#>, feedId: <#T##Int#>, delegate: <#T##CommentViewController#>)
    }
    
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.commentId.text = commentInfo[indexPath.row].loginId
        cell.commentText.text = commentInfo[indexPath.row].commentText
        cell.createdAt.text = commentInfo[indexPath.row].createdAt
        return cell
    }
    
    
}
