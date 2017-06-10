//
//  SearchListCollectionViewCell.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/9/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import moa

class SearchListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchListCollectionViewCell"

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var distanceCell: UILabel!
    
    override func awakeFromNib() {
        self.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height)
    }
    
    func setCell(obejcts:MapModel?,index:Int){
        
        print("obejcts ",obejcts)
        
//        self.titleCell.text = obejcts?.getPlacesObjects(at: index, key: "english")
//        self.distanceCell.text = obejcts?.getPlacesObjects(at: index, key: "thai")
//        self.imageCell.moa.url = "http://www.discoverythailand.com/Images/Place/ID_976_Large.jpg"
    }
}
