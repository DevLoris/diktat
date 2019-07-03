//
//  HistoryDetailsViewHelper.swift
//  DiktatBeauty
//
//  Created by Hugo on 01/07/2019.
//  Copyright © 2019 Hugo Duval. All rights reserved.
//

import Foundation
import UIKit

class HistoryDetailsViewHelper {
    static func createAndPopulateCell(indexPath: IndexPath, tableView: UITableView, node: ImageNode) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "posterCell", for: indexPath)
            
            if let c = cell as? HistoryPosterTableViewCell {
                c.populateWith(value: node)
            }
            
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
            
            if let c = cell as? HistorySubtitleTableViewCell {
                c.populateWith(value: node)
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
        
        if let c = cell as? HistoryTextTableViewCell {
            c.populateWith(value: node)
        }
        return cell
    }
}
