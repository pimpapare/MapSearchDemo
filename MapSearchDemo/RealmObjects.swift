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

//    func setMapObjects(id:Int, name:String,lat:Double,lng:Double,image:String,distance:Int){
//        
//        //        for title in defaultSubscribe {
//        let subscribe = Subscribe()
//        writeMapObject(id:id, name: name, lat: lat, lng: lng,image:image, distance: distance)
//        //        }
//    }
    
    //    func setMapImageWithIndex(id:Int, image:Data){
    //
    //        //        for title in defaultSubscribe {
    //        let subscribe = Subscribe()
    //
    //        let objectMap = realm.objects(Subscribe.self).filter("id =\(id)")
    //
    //        try? realm.write({
    //            for channel in objectMap {
    //                channel.image = image
    //            }
    //        })
    //    }
    
    func writeMapObject(id:Int, name:String,lat:Double,lng:Double,image:String,distance:Int){
        
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
        
        let sortedMovies = objects.sorted(by: { $0.name < $1.name })

        print("== ",sortedMovies)
        
        return sortedMovies
    }
}
