//
//  HistoryCollectionViewCell.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 25/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell { 
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    public func populateWith(value:ImageNode) {
        print("pop" + value.identifier)
        
        populateImageFrom(id: value.identifier)
    }
    
    public func populateImageFrom(id:String) {
        let ui = UIImage(named:  id + "__poster");
        posterImageView.image = ui
    }
}
