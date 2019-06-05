//
//  HistoryTextTableViewCell.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 05/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import UIKit

class HistoryTextTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.backgroundColor = .clear
        
        self.bounds.size.height = textView.bounds.size.height 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func populateWith(value:ImageNode) {
    }
}
