//
//  MapViewModel.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/9/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import IGListKit
import CoreLocation

class MapViewModel: BaseViewModel {
    
    var map = [LoadingType.refresh.rawValue as ListDiffable]
    var dicPlaces:[String:AnyObject]?
    var realmObjects:RealmObjects = RealmObjects()
    
    func zoomCamera(sliderValue:Float) -> Float {
        
        let result = 15 - 0.55 * Float(Int(sliderValue * 10))
        if result < 14 , result > 12 {
            return 11
        }else if result < 12 , result > 9 {
            return 10
        }
        return result
    }
    
    func distanceValueText(sliderValue:Float) -> String {
        
        let result = Int(sliderValue * 50)
        if result > 0{
            return "\(result) KM"
        }
        return "1 KM"
    }
    
    func getArrayMarker() -> String{
        let iconNameArray = ["ic_place_green","ic_place_blue","ic_place_yellow"]
        let randomIndex = Int(arc4random_uniform(UInt32(iconNameArray.count)))
        return iconNameArray[randomIndex] as String
    }
    
    func getRadiusFromSliderValue(sliderValue:Float) -> Int {
        let result = Int(sliderValue * 10) * 5
        return (result == 0) ? 1 : (result * 1000)
    }
    
    func callService(location:String,radius:Int,key:String) {
        let router = Router.getPlaceList(location: location, radius: radius, key: key)
        _ = APIRequest.request(withRouter: router, withHandler: getListMapHandler())
    }
    
    func getListMapHandler() -> APIRequest.completionHandler {
        
        return { [weak self] (response, error) in
            
            if let response = response as? MapModel {
                
                self?.dicPlaces = response.dic
                
                self?.map.append(response)
                self?.delegate?.onDataDidLoad()
                
            } else {
                self?.delegate?.onDataDidLoadErrorWithMessage(errorMessage: (error?.localizedDescription)!)
            }
        }
    }
    
    func getMarker() -> [[String:AnyObject]]?{
        let object: MapModel = MapModel(withDictionary: dicPlaces!)
        return object.places
    }
    
    func getPlacesObjects(at index:Int, key:String) -> String{
        let getObjects = PlaceValue.init(places: getMarker())
        return getObjects[index,key] as! String
    }
    
    func getPlacesLocationLatLng(at index:Int, key:String) -> Double{
        
        let objectIndex = getMarker()?[index]
        let geometryObject = objectIndex?["geometry"] as! [String:AnyObject]
        let locationObject = geometryObject["location"] as! [String:AnyObject]
        return locationObject[key] as! Double
    }
    
    func getPlacesImage(at index:Int) -> String{
        
        let objectIndex = getMarker()?[index]
        
        if let photosObject = objectIndex?["photos"] as? [[String:AnyObject]] {
            let referenceObject = photosObject[0]["photo_reference"]
            return referenceObject as? String ?? " "
        }
        return " "
    }
    
    func getUserLocation() -> (Double,Double) {
        let userLocation = UserDefaults.standard.object(forKey:.userLocation) as? [String:Double]
        return (userLocation?["lat"] ?? .defaultLat, userLocation?["lng"] ?? .defaultLng)
    }
    
    func getCalculateDistance(lat :Double,lng :Double) -> Int{
        
        print("lat ",self.getUserLocation().0)
        print("lng ",self.getUserLocation().1)
        
        let coordinateUserLocation = CLLocation(latitude: self.getUserLocation().0, longitude: self.getUserLocation().1)
        let coordinateUserSelectedLocation = CLLocation(latitude: lat, longitude: lat)
        
        
        let distanceInMeters = coordinateUserLocation.distance(from: coordinateUserSelectedLocation)
        
        return Int(distanceInMeters / 1000.0) //km
    }
    
    func getPlaceCount() -> Int{
        let result:Int = (getMarker()?.count ?? 1) - 1
        guard result > 0 else {
            return 0
        }
        return result
    }
    
    func setMapObjects(id:Int, name:String,lat:Double,lng:Double,image:String,distance:Int){
        realmObjects.writeMapObject(id:id, name: name, lat: lat, lng: lng,image:image, distance: distance)
    }
    
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
}
