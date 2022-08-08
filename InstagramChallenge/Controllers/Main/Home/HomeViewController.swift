
import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private let feedDataService = FeedDataService()
    var feedInfo = [FeedsResponseResult]()
    private var currentPage = 0
    var fetchMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        feedDataService.requestFetchFeeds(pageIndex: currentPage, delegate: self)
    }
    
    func didSuccessFeedData(result: [FeedsResponseResult]) {
        feedInfo.append(contentsOf: result)
        tableView.reloadData()
    }
    
    @IBAction func goToCreatePost(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PhotoSelectViewController") as? PhotoSelectViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func goChatView(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "ChatViewController") as? ChatViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    func beginBatchFetch() {
        fetchMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.currentPage += 1
            
            self.feedDataService.requestFetchFeeds(pageIndex: self.currentPage, delegate: self)
           
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
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return feedInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath) as! HomeStoryCell
             return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! HomeFeedCell
        cell.delegate = self
        cell.index = indexPath.row
        cell.feedLoginId.text = feedInfo[indexPath.row].feedLoginId
        cell.feedText.text = feedInfo[indexPath.row].feedText
        cell.feedCreatedAt.text = feedInfo[indexPath.row].feedCreatedAt
        cell.feedCommentCount.text =
        "\(feedInfo[indexPath.row].feedCommentCount ?? 0)개"
        
        
        return cell
    }
}

extension HomeViewController: MoveCommentViewDelegate {
    func moveCommentView(index: Int, pharse: String) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CommentViewController") as? CommentViewController else { return }
        vc.pharse = pharse
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}

