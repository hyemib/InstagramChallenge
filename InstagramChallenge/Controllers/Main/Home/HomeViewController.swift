
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let data = ["ena", "e", "n", "a"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath) as! HomeStoryCell
             return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! HomeFeedCell
        cell.delegate = self
        cell.index = indexPath.row
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

