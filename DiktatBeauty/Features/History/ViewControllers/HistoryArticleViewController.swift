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
    }
    
    func populate(node: ImageNode){
        mainTitle.text = node.title
        transparentTitle.text = node.title
        articleText.text = node.text
        posterImageView.image = UIImage(named: node.identifier + "__poster")
    }
    

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true) {
        }
    }
}
