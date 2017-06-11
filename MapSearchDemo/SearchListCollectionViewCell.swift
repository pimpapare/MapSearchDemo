//
//  SearchListCollectionViewCell.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/9/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import moa
import Alamofire
import AlamofireImage

class SearchListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchListCollectionViewCell"
    var searchViewModel:SearchViewModel?
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var distanceCell: UILabel!
    
    override func awakeFromNib() {
        self.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:self.frame.size.height)
        let searchListViewController = SearchListViewController()
        searchViewModel = SearchViewModel(delegate: searchListViewController)
    }
    
    func setCell(objects:Subscribe,index:Int){
                
        self.titleCell.text = objects.name
        self.distanceCell.text = "\(objects.distance)"
        self.imageCell.moa.url = objects.image  
    }
}
