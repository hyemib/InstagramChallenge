
import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private let feedDataService = FeedDataService()
    var feedInfo = [FeedsResponseResult]()
    private var currentPage = 0
    var fetchMore = false
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        feedDataService.requestFetchGetFeed(pageIndex: currentPage, size: 10, delegate: self)
       
        initRefresh()
    }
    
    func didSuccessFeedData(result: [FeedsResponseResult]) {
        feedInfo.append(contentsOf: result)
        tableView.reloadData()
    }
    
    func initRefresh() {
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
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
            
            self.feedDataService.requestFetchGetFeed(pageIndex: self.currentPage, size: 10, delegate: self)
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
    
    func getCurrentDate() -> Int {
        let current = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let currentDate = formatter.string(from: current).components(separatedBy: "-")
        return Int(currentDate.joined())!
        
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
        cell.feedId = feedInfo[indexPath.row].feedLoginId
        cell.feedIndex = feedInfo[indexPath.row].feedId
        cell.feedInfo = feedInfo[indexPath.row]
        cell.contents = CommentContents(feedLoginId: feedInfo[indexPath.row].feedLoginId!, feedText: feedInfo[indexPath.row].feedText!, feedCreatedAt: feedInfo[indexPath.row].feedCreatedAt!)
        
        cell.feedLoginId.text = feedInfo[indexPath.row].feedLoginId
        cell.feedLoginId2.text = feedInfo[indexPath.row].feedLoginId
        var textArr = (feedInfo[indexPath.row].feedText)?.components(separatedBy: "\n")
        cell.feedText.text = textArr?[0]
        textArr?.removeFirst()
        if textArr?.count ?? 0 >= 1 {
            cell.feedMoreText.text = textArr?.joined(separator: "\n")
        }
        cell.feedCommentCount.text = "\(feedInfo[indexPath.row].feedCommentCount ?? 0)개"
        
        cell.pageControl.numberOfPages = feedInfo[indexPath.row].contentsList?.count ?? 0
        cell.pageControl.currentPage = 0
        cell.pageControl.pageIndicatorTintColor = UIColor.mainLightGrayColor
        cell.pageControl.currentPageIndicatorTintColor = UIColor.mainBlueColor
        if feedInfo[indexPath.row].contentsList?.count ?? 0 <= 1 {
            cell.pageControl.isHidden = true
            cell.feedImageCountView.isHidden = true
        }
        let url = URL(string: (feedInfo[indexPath.row].contentsList?[0].contentsUrl)!)
        cell.feedContets.load(url: url!)
        
        cell.feedCreatedAt.text = setDate(feedInfo[indexPath.row].feedCreatedAt!)
        return cell
    }
}

extension HomeViewController: SendHomeDelegate {
    func movePopupView(index: Int, feedInfo: FeedsResponseResult) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PopUpViewController") as? PopUpViewController else { return }
        vc.feedInfo = feedInfo
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    func moveCommentView(index: Int, feedIndex: Int, contents: CommentContents?) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CommentViewController") as? CommentViewController else { return }
        vc.feedIndex = feedIndex
        vc.contents = contents
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}

