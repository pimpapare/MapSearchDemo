//
//  MapViewModel.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/9/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit

class MapViewModel: NSObject {
    
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
}
