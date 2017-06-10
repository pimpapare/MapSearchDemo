//
//  HistorySectionController.swift
//  NongBeer
//
//  Created by Thongpak on 4/10/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit
import IGListKit

enum LoadingType: String {
    case refresh, loadmore
}

class MapSectionController: ListSectionController {
    
    var object: MapModel?
    
    override func numberOfItems() -> Int {
        return (object?.places?.count) ?? 0
    }
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = 5
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width:UIScreen.main.bounds.width, height: 100)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell = collectionContext?.dequeueReusableCell(withNibName: SearchListCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! SearchListCollectionViewCell
        cell.setCell(obejcts: object,index: index)
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.object = object as? MapModel
    }
    
    override func didSelectItem(at index: Int) {
    }
}
