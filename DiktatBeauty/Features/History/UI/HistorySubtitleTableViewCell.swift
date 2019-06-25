//
//  HistorySubtitleTableViewCell.swift
//  DiktatBeauty
//
//  Created by Hugo Duval on 24/06/2019.
//  Copyright © 2019 Hugo Duval. All rights reserved.
//

import UIKit

class HistorySubtitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            textView.font = textView.font?.withSize(78)
            leftMargin.constant = 50
            rightMargin.constant = 50
            break
        default:
            textView.font = textView.font?.withSize(36)
            leftMargin.constant = 10
            rightMargin.constant = 10
        }
        
        
        self.bounds.size.height = textView.bounds.size.height
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populateWith(value: ImageNode) {
        textView.text = value.subtitle
    }
}
