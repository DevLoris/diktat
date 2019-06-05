//
//  HistoryDetailsViewController.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 05/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import UIKit

class HistoryDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var contentTableView: UITableView!
    
    var node:ImageNode? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        node = ImageNode(identifier: "anorexia", title: "Anorexie", layers: [])
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.allowsSelection = false
        contentTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let n = node {
            if(indexPath.row == 0) {
                cell = tableView.dequeueReusableCell(withIdentifier: "posterCell", for: indexPath)
                
                if let c = cell as? HistoryPosterTableViewCell {
                    c.populateWith(value: n)
                }
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
                
                if let c = cell as? HistoryTextTableViewCell {
                    c.populateWith(value: n)
                }
            }
        }
        
        return cell
    }
    
    
    @IBAction func closeAllButtonAction(_ sender: Any) {
        dismiss(animated: true) { }
    }
}
