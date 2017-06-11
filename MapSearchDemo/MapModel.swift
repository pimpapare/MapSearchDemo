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
    
//    func getPlacesObjects(at index:Int, key:String) -> String{
//        let getObjects = PlaceValue.init(places: places)
//        return getObjects[index,key] as! String
//    }
//    
//    func getPlacesLocationLatLng(at index:Int, key:String) -> Double{
//        
//        let objectIndex = places?[index]        
//        let geometryObject = objectIndex?["geometry"] as! [String:AnyObject]
//        let locationObject = geometryObject["location"] as! [String:AnyObject]
//        return locationObject[key] as! Double
//    }
//    
//    func getPlaceCount() -> Int{
//        return places?.count
//    }
}

class MapImageModel: BaseModel {
    
    var placesImage:[[UIImage]]?
    var dicImage:UIImage?

    required init(withImage image: UIImage) {
        super.init(withDictionary: ["":"" as AnyObject])
        self.dicImage = image
        print("dict ",image)
        
//        self.dic = dict
//        self.places = dict["results"] as? [[String : AnyObject]]
    }
    
    public required init(withDictionary dict: [String : AnyObject]) {
        fatalError("init(withDictionary:) has not been implemented")
        super.init(withDictionary: dict)
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
