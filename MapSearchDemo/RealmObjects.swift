//
//  RealmObjects.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/11/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import RealmSwift

class RealmObjects: NSObject {

    let realm = try! Realm()
    
    func writeMapObject(id:Int, name:String,lat:Double,lng:Double,image:String,distance:String){
        
        let subscribe = Subscribe()
        
        try! realm.write {
            
            subscribe.id = id
            subscribe.name = name
            subscribe.lat = lat
            subscribe.lng = lng
            subscribe.image = image
            subscribe.distance = distance
            
            realm.add(subscribe)
        }
    }
    
    func removeMapObjects(){
        
        try! realm.write {
            realm.delete(realm.objects(Subscribe.self))
        }
    }
    
    func getMapObjects() -> [Subscribe]{
        
        guard realm.objects(Subscribe.self).first != nil else {
            return getMapObjects()
        }
        
        let objects = realm.objects(Subscribe.self).toArray(ofType : Subscribe.self) as [Subscribe]
        return objects
    }
    
    func getMapObjectsWithSortName() -> [Subscribe]{
        
        let sortedMovies = getMapObjects().sorted(by: { $0.name < $1.name })
        return sortedMovies
    }
}
