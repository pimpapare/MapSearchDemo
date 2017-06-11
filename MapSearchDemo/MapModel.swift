//
//  MovieModel.swift
//  MovieDemo
//
//  Created by pimpaporn chaichompoo on 6/5/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import Foundation
import IGListKit

class MapModel: BaseModel {
    
    var places:[[String:AnyObject]]?
    var dic:[String:AnyObject]?
    
    required init(withDictionary dict: [String:AnyObject]) {
        super.init(withDictionary: dict)
        self.dic = dict
        self.places = dict["results"] as? [[String : AnyObject]]
    }
}

struct PlaceValue {
    
    var places:[[String:AnyObject]]?
    
    subscript (_ index:Int,_ key:String) -> AnyObject?{
        return places?[index][key]
    }
}

extension MapModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
