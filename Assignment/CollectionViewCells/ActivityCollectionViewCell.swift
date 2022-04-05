//
//  ActivityCollectionViewCell.swift
//  Assignment
//
//  Created by Harshit Malhotra on 2022-03-31.
//

import UIKit

class ActivityCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityPrice: UILabel!
    
    
    // 1. Setting the background color & values of the UI elements inside the custom Collection View Cell 
    func populateActivityCollectionCell(currentActivity: Activity){
        
        activityImage.image = UIImage(named: currentActivity.getPhoto())
        activityName.text = currentActivity.getName()
        activityPrice.text = "$\(currentActivity.getPrice().priceFormat)/ person"
        
        // -If the activity has a popular tag then change the backgroung color
        if( currentActivity.getTags() == "popular"){
            backgroundColor = UIColor.systemYellow
        }
    }
}
