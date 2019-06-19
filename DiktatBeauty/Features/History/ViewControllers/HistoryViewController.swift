//
//  HistoryViewController.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 25/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyCollectionView: UICollectionView!
    
    var clickedItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }
      
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toHistoryDetails") {
            if let destinationViewController = segue.destination as? HistoryDetailsViewController {
                destinationViewController.node =
                    Array(Recognitazed.instance.nodes)[clickedItem].value
            }
        }
        if(segue.identifier == "toHistoryArticle") {
            if let destinationViewController = segue.destination as? HistoryArticleViewController {
                destinationViewController.node = (Array(Recognitazed.instance.nodes)[clickedItem].value)
            }
        }
    }
}



extension HistoryViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickedItem = indexPath.item
        self.performSegue(withIdentifier: "toHistoryArticle", sender: self)
    }
}

extension HistoryViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3 - 10, height: collectionViewWidth/2.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HistoryViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Recognitazed.instance.nodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryVars.CELL.rawValue, for: indexPath)
        
        if let c = cell as?HistoryCollectionViewCell {
            let node = Array(Recognitazed.instance.nodes)[indexPath.row].value;
            c.populateWith(value: node)
        }
        
        return cell;
    }
}
