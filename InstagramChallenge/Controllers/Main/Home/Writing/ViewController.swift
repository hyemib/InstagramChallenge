//
//  ViewController.swift
//  InstagramChallenge
//
//  Created by hyemi on 2022/08/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func yeyeye(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PostWriteViewController") as? FeedWriteViewController else { return }
        //vc.selectImage = selectImage
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
  
}
