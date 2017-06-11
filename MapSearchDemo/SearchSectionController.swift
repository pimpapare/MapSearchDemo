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
    
    var object: MapModel?
    lazy var mapViewModel:MapViewModel = MapViewModel(delegate: self as! BaseViewModelDelegate)

    override func numberOfItems() -> Int {
        print(">> ",(object) ?? 0)
        print(">> ",(object?.places?.count) ?? 0)
        print(">> ",mapViewModel.getPlaceCount())

        return mapViewModel.getPlaceCount() ?? 0
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
