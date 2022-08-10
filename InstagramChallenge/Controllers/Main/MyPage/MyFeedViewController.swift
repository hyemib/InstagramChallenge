
import UIKit
import Kingfisher

class MyFeedViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let feedDataService = FeedDataService()
    var feedInfo = [FeedsResponseResult]()
    var fetchMore = false
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        feedDataService.requestFetchGetFeedUser(pageIndex: currentPage, loginId: Constant.myId, delegate: self)
    }
    
    func setMyPageFeed(resut: [FeedsResponseResult]) {
        feedInfo = resut
        collectionView.reloadData()
    }
    
    func beginBatchFetch() {
        fetchMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.currentPage += 1
            
            self.feedDataService.requestFetchGetFeedUser(pageIndex: self.currentPage, loginId: Constant.myId, delegate: self)
            self.collectionView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y > (collectionView.contentSize.height - collectionView.bounds.size.height) {
            if !fetchMore {
                beginBatchFetch()
            }
            
        }
    }
}


extension MyFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFeedCell", for: indexPath) as! MyFeedCell
        let imageUrl = URL(string: (feedInfo[indexPath.row].contentsList?[0].contentsUrl)!)
        cell.feedImage.load(url: imageUrl!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3
        return CGSize(width: width, height: width)
    }
}

