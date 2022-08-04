
import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var feedPharse: UITextView!
    
    var pharse = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        feedPharse.text = pharse
        
        //feedView.frame =  CGRect(x: 0, y: 0, width: tableView.frame.width, height: feedPharse.frame.height)
    }
    
    @IBAction func returnHomeView(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        return cell
    }
    
    
}
