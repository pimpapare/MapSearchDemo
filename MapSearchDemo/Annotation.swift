//
//  Annotation.swift
//  JetztraApplication
//
//  Created by Dhanu Saksrisathaporn on 2/2/2560 BE.
//  Copyright © 2560 20SCOOPS. All rights reserved.
//

import MapKit
// create new post request
class CircleAnimateOverlayRenderer : MKCircleRenderer{
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        var r = mapRect
        r.size.width *= 100
        r.size.height *= 100
        super.draw(r, zoomScale: zoomScale, in: context)
    }
}

class Annotation:NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    init(_ coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    func viewForMap(_ mapView:MKMapView)->MKAnnotationView{
        let v = mapView.dequeueReusableAnnotationView(withIdentifier: .defaultAnnotationID) as? PinAnnotationView ??
            PinAnnotationView(annotation:self, reuseIdentifier: .defaultAnnotationID)
        v.annotation = self
        return v
    }
}

class MyAnnotation:Annotation {
    override func viewForMap(_ mapView:MKMapView)->MKAnnotationView{
        let v = mapView.dequeueReusableAnnotationView(withIdentifier: .mainAnnotationID) as? MyPinAnnotationView ??
            MyPinAnnotationView(annotation:self, reuseIdentifier: .mainAnnotationID)
        v.annotation = self
        return v
    }
}

class PinAnnotationView: MKAnnotationView {
    open var pin:UIImage { get {return #imageLiteral(resourceName: "icPin")} }
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setDisplay()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setDisplay() {
        backgroundColor = UIColor.clear
        bounds = CGRect(x: 0, y: 0, width: pin.size.width, height:pin.size.height )
        let imv = UIImageView(image: pin)
        imv.backgroundColor = UIColor.clear
        imv.frame = bounds
        addSubview(imv)
    }
}
class MyPinAnnotationView: PinAnnotationView {
    override var pin:UIImage { get {return #imageLiteral(resourceName: "icPinGreenStyle2")} }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setDisplay()
    }
}
class AnnotationView: MKAnnotationView {
    var dotSize:CGFloat = 30.0
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        bounds = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
        clipsToBounds = false
        
        let foreColor = #colorLiteral(red: 0, green: 0.7620447278, blue: 0.3949387074, alpha: 1)
        let borderColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        let borderWidth:CGFloat = 3
        
        let dot = UIView(frame : CGRect(x:0, y:0, width: dotSize, height: dotSize))
        dot.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        dot.backgroundColor = foreColor
        dot.layer.cornerRadius = dotSize * 0.5
        dot.layer.borderColor = borderColor.cgColor
        dot.layer.borderWidth = borderWidth
        dot.layer.masksToBounds = true
        addSubview(dot)
    }
    
    //    func setRadius(radius:CGFloat) {
    //        self.radiusView.layer.cornerRadius = radius * self.zoneSize * 0.5
    //        self.radiusView.bounds = CGRect(x: 0, y: 0, width: radius * self.zoneSize, height: radius * self.zoneSize)
    //        self.radiusView.center = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
    //    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
