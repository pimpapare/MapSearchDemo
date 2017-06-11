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
    
    func sizeForTopOfCollectionView() -> CGFloat{
        
        guard UIDevice.current.orientation.isLandscape else {
            return 20
        }
        return 0
    }
    
    func zoomCamera(sliderValue:Float) -> Float {

        let result = 14 - 0.55 * Float(Int(sliderValue * 10))
        if result < 14 , result > 9 {
            return 9.5
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
        print("object ",object.places)
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
    
    func getPlaceCount() -> Int{
        let result:Int = (getMarker()?.count ?? 1) - 1
        guard result > 0 else {
            return 0
        }
        return result
    }
}
