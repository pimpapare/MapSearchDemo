//
//  Constant.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit

class Constant {
    
    static let DEVICE_W = UIScreen.main.bounds.width
    static let DEVICE_H = UIScreen.main.bounds.height
    
}

public extension NSNotification.Name {
    public static let updateCell:NSNotification.Name = NSNotification.Name(rawValue: "updateCell")
}

public extension Double {
    
    public static let defaultLat = 18.7061
    public static let defaultLng = 98.9817

}
public extension String {
    
    public static let BASE_URL = "https://maps.googleapis.com/maps/api/"
    public static let GOOGLE_KEY = "AIzaSyCwwzJ3TymPLZz7OW7LfU-pOSlYqpUvQFc"
    public static let GOOGLE_API = "AIzaSyCZ1BCe4Q7YL1nCa_ovtet4Bjn52tT20T8"

    public static let segueGoToMapStoryBoard = "goToMapStoryBoard"

    public static let cell = "Cell"
    
    public static let userLocation = "USER_LOCATION"
    public static let userSelectedLocation = "USER_SELECTED_LOCATION"

    //Main Map
    public static let txTitleHeader = "iOS Developer"
    public static let txBtnSearch = "Search"
    public static let txTitleSlider = "Choose your location and set distance"

    public static let txBtnMap = "Map"

    public static let defaultAnnotationID = "annotationID"
    public static let mainAnnotationID = "userAnnotationID"

    //Error
    public static let errorTitle = "Error"
    public static let errorSubTitle = "Error. Please try again later."

    public static let ok = "OK"
    public static let unitDistance = "KM"

    
    var countryName : String? {
        return (Locale.current as NSLocale).displayName(forKey: .countryCode, value: self)
    }

    static var countryName : String? {
        return Locale.current.regionCode?.countryName
    }
}
