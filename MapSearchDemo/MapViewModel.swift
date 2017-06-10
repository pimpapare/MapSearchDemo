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

    func sizeForBottomOfViewSliderFromTapGesture(constant:CGFloat) -> CGFloat{
        
        if constant == -75 {
            return 0
        }else{
            return -75
        }
    }
    
    func sizeForBottomOfViewSliderFromPanGesture(velocityY:CGFloat) -> CGFloat {
        
        if velocityY < 0 {
            return 0
        }else{
            return -75
        }
    }
    
    func zoomCamera(sliderValue:Float) -> Float {
        return (sliderValue * 5) * 4
    }
    
    func distanceValueText(sliderValue:Float) -> String {
        
        if Int(sliderValue * 50) > 0{
            return "\(Int(sliderValue * 50)) KM"
        }
        return "1 KM"
    }
    
    func getRadiusFromSliderValue(sliderValue:Float) -> Int {
        return Int(((sliderValue * 1000) == 0.0) ? 1 : sliderValue  * 1000)
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
        
        //เก็บ lat lnd name
        let object: MapModel = MapModel(withDictionary: dicPlaces!)
        return object.places
        
       /* print("== ",object.getPlacesLocationLatLng(at: 0, key: "lat"))
        print("== ",object.getPlacesObjects(at: 0, key: "name"))
        
        return dicPlaces!
        for i in 0...object.getPlaceCount() {
            
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(object.getPlacesLocationLatLng(at: i, key: "lat")), longitude: object.getPlacesLocationLatLng(at: i, key: "lng"))
            var icon:UIImage = UIImage(named: "ic_place")!.withRenderingMode(.alwaysOriginal)
            icon = self.resizeImage(image:icon,width: 20,height:35)
            marker.icon = icon
            
            marker.map = mapView

        }
 */
//        for i in 0...Int(objectPlaces?.count ?? 0) {
//            print("i ",i)
//            let objectIndex = objectPlaces?[i]
//            print("objectIndex ",objectIndex)
//            
//            let geometryObject = objectIndex?["geometry"] as! [String:AnyObject]
//            let locationObject = geometryObject?["location"] as! [String:String]
//
//            print("geometryObject ",geometryObject)
//            
//        }
        
//        return [[String:AnyObject]]
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
    
    func getPlaceCount() -> Int{
        return (getMarker()?.count ?? 1) - 1
    }
}
