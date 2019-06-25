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
    @IBOutlet weak var titleTextView: UILabel!
    
    @IBOutlet weak var closeIconWidth: NSLayoutConstraint!
    
    var node: ImageNode? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.allowsSelection = false
        contentTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        if let n = node {
            titleTextView.text = n.title
        }
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            closeIconWidth.constant = 48
            break
        default:
            closeIconWidth.constant = 24
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            var margins: CGFloat;
            
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                margins = 150
                break
            default:
                margins = 10
            }
            
            return (75/52) * (tableView.bounds.width - margins*2) - 50
        }
        
        if indexPath.row == 1 {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return 180
            default:
                return 100
            }
        }
        
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        guard let n = node else { return cell }
            
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "posterCell", for: indexPath)
            
            if let c = cell as? HistoryPosterTableViewCell {
                c.populateWith(value: n)
            }
            
            return cell
        }
        
        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
            
            if let c = cell as? HistorySubtitleTableViewCell {
                c.populateWith(value: n)
            }
            
            return cell
        }
        
        cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
        
        if let c = cell as? HistoryTextTableViewCell {
            c.populateWith(value: n)
        }
        
        return cell
    }
    
    
    @IBAction func closeAllButtonAction(_ sender: Any) {
        dismiss(animated: true) { }
    }
}
