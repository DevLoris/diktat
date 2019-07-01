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
    
    // Adapt table cells height according to device type
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Poster table cell
        if indexPath.row == 0 {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return (75 / 52) * (tableView.bounds.width - 300) - 50
            default:
                return (75 / 52) * (tableView.bounds.width - 20) - 50
            }
        }
        
        // Title table cell
        if indexPath.row == 1 {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return 180
            default:
                return 100
            }
        }
        
        // Text table cell
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let n = node else { return UITableViewCell() }
        
        return HistoryDetailsViewHelper.createAndPopulateCell(indexPath: indexPath, tableView: tableView, node: n)
    }
    
    
    @IBAction func closeAllButtonAction(_ sender: Any) {
        dismiss(animated: true) { }
    }
}
