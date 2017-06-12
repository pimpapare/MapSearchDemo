//
//  MapViewModel.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/9/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import IGListKit

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
    
    func getZoomLocation(userLocation:Bool) -> [Double] {
        
        var location:[Double] = [.defaultLat,.defaultLng]
        
        if userLocation == true {
            location = [self.getUserLocation().0,self.getUserLocation().1]
        }else{
            location = [self.getUserSelectedLocation().0,self.getUserSelectedLocation().1]
        }
        return location
    }
    
    func validateCenterMarker(lat:Double,lng:Double) -> [Double]{
        
        if lat <= 0 || lng <= 0 {
            return [.defaultLat,.defaultLng]
        }else{
            return [lat ,lng]
        }
    }
    
    func distanceValueText(sliderValue:Float) -> String {
        
        let result = Int(sliderValue * 50)
        if result > 0{
            return "\(result) " + .unitDistance
        }
        return "1 " + .unitDistance
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
    
    func setImageURL(baseurl:String,imageRef:String,gooleAPI:String) -> String {
        return "\(baseurl)place/photo?maxwidth=400&photoreference=\(imageRef)&key=\(gooleAPI)"
    }
    
    func getListMapHandler() -> APIRequest.completionHandler {
        
        return { [weak self] (response, error) in
            
            if let response = response as? MapModel {
                
                if let errorMessage = response.dic?["error_message"] {
                    self?.delegate?.onDataDidLoadErrorWithMessage(errorMessage: errorMessage as! String)
                }else{
                    
                    let txStatus = response.dic?["status"] as! String
                    
                    if txStatus != "OK"{
                        self?.delegate?.onDataDidLoadErrorWithMessage(errorMessage: txStatus)
                    }else{
                        self?.dicPlaces = response.dic
                        
                        self?.map.append(response)
                        self?.delegate?.onDataDidLoad()
                    }
                }
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
            return setImageURL(baseurl: .BASE_URL, imageRef: referenceObject as? String ?? " ", gooleAPI: .GOOGLE_API)
        }
        return " "
    }
    
    func getUserLocation() -> (Double,Double) {
        let userLocation = UserDefaults.standard.object(forKey:.userLocation) as? [String:Double]
        return (userLocation?["lat"] ?? .defaultLat, userLocation?["lng"] ?? .defaultLng)
    }
    
    func getUserSelectedLocation() -> (Double,Double) {
        let userLocation = UserDefaults.standard.object(forKey:.userSelectedLocation) as? [String:Double]
        return (userLocation?["lat"] ?? .defaultLat, userLocation?["lng"] ?? .defaultLng)
    }
    
    func getCalculateDistance(lat :Double,lng :Double) -> String{
        
        let latStart = self.getUserSelectedLocation().0
        let lngStart = self.getUserSelectedLocation().1
        
        let R:Double = 6371
        let dLat = deg2rad(num: lat - latStart)
        let dLon = deg2rad(num: lng - lngStart)
        
        let a = sin(dLat/2) * sin(dLat/2) +
            cos(deg2rad(num: latStart)) * cos(deg2rad(num: lat)) *
            sin(dLon/2) * sin(dLon/2)
        
        let c = 2 * atan2(sqrt(a),sqrt(1-a))
        let distance = R * c
        
        return String(format: "%.2f km",distance)
    }
    
    func deg2rad(num:Double) -> Double {
        return num * .pi / 180
    }
    
    func getPlaceCount() -> Int{
        let result:Int = (getMarker()?.count ?? 1) - 1
        guard result > 0 else {
            return 0
        }
        return result
    }
    
    func setMapObjects(id:Int, name:String,lat:Double,lng:Double,image:String,distance:String){
        realmObjects.writeMapObject(id:id, name: name, lat: lat, lng: lng,image:image, distance: distance)
    }
}
