//
//  HistoryPosterTableViewCell.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 05/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import UIKit

class HistoryPosterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib() 
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.backgroundColor = .clear

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func populateWith(value:ImageNode) {
    }
    
}
