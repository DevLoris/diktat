//
//  HistoryPosterTableViewCell.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 05/06/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import UIKit

class HistoryPosterTableViewCell: UITableViewCell {
    @IBOutlet weak var leftMargin: NSLayoutConstraint!
    @IBOutlet weak var rightMargin: NSLayoutConstraint!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            leftMargin.constant = 50
            rightMargin.constant = 50
            break
        default:
            leftMargin.constant = 10
            rightMargin.constant = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func populateWith(value: ImageNode) {
        populateImageFrom(id: value.identifier)
    }
    
    public func populateImageFrom(id: String) {
        let ui = UIImage(named: id + "__poster");
        posterImageView.image = ui
    }
    
}
