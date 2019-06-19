//
//  HistoryArticleViewController.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 19/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import UIKit

class HistoryArticleViewController: UIViewController {
    var node: ImageNode? = nil
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var transparentTitle: UILabel!
    @IBOutlet weak var articleText: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let n = node {
            populate(node: n)
        }
        // Do any additional setup after loading the view.
    }
    
    func populate(node: ImageNode){
        mainTitle.text = node.title
        transparentTitle.text = node.title
        articleText.text = node.text
        //posterImageView.image = UIImage(named: node.identifier + "__poster")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true) {
        }
    }
}
