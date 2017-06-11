//
//  SearchViewModel.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/11/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import IGListKit
import RealmSwift
import CoreLocation

class SearchViewModel: BaseViewModel {

    var map = [LoadingType.loadmore.rawValue as ListDiffable]
    
    let realm = try! Realm()
    var mapViewModel:MapViewModel?
    var searchListViewController:SearchListViewController!

    var dicImagePlaces:UIImage?

    func getMapObjects(objects:[Subscribe]) {
        
        let mapObjects = objects as [AnyObject]
        print("mapObjects ",mapObjects)

        callService(maxwidth: 400, photoreference: mapObjects[0]["image"] as? String ?? "", key: .GOOGLE_API)
    }
    
    func callService(maxwidth:Int,photoreference:String,key:String) {
        let router = Router.getPhotoList(maxwidth: maxwidth, photoreference: photoreference, key: key)
        _ = APIRequest.requestImage(withRouter: router, withHandler: getListImageHandler())
    }
    
    func getListImageHandler() -> APIRequest.completionHandler {
        
        return { [weak self] (response, error) in
            
            if error == nil {
                
                self?.searchListViewController = SearchListViewController()
                self?.mapViewModel = MapViewModel(delegate: (self?.searchListViewController)!)
                print("response ",response) // ได้ IMAGE
                
                let data = NSData(data: UIImagePNGRepresentation(response as! UIImage)!)
                

//                self?.dicImagePlaces = response.dicImage
//                print("dicImagePlaces ",self?.dicImagePlaces)
                // save ใส่ realm
                
                
                self?.delegate?.onImageDataDidLoad()
                
            } else {
                self?.delegate?.onDataDidLoadErrorWithMessage(errorMessage: (error?.localizedDescription)!)
            }
        }
    }
    
//    func getImageMarker() -> [UIImage]?{
//        
//        let object: MapImageModel = MapImageModel(withImage: dicImagePlaces!)
//        print("object ",object.placesImage)
//        return [UIImage]?
//            //object.placesImage
//    }

}
