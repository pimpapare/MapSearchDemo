//
//  SearchSectionController.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/9/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import IGListKit

enum LoadingType: String {
    case refresh, loadmore
}

class SearchSectionController: ListSectionController {
    
    var objects: [Subscribe]?
    var realmObject:RealmObjects? = RealmObjects()
    
    override func numberOfItems() -> Int {
        
        objects = realmObject?.getMapObjectsWithSortName()
        return objects?.count ?? 0
    }
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width:UIScreen.main.bounds.width, height: 80)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cell = collectionContext?.dequeueReusableCell(withNibName: SearchListCollectionViewCell.identifier, bundle: nil, for: self, at: index) as! SearchListCollectionViewCell
        cell.setCell(objects: objects![index] ,index: index)
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        objects = realmObject?.getMapObjectsWithSortName()
    }
    
    override func didSelectItem(at index: Int) {
    }
}
