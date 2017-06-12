//
//  MapViewController.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: BaseViewController,GMSMapViewDelegate {
    
    @IBOutlet weak var txSlider: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var vPin: UIView!
    @IBOutlet weak var vFooter: UIView!
    @IBOutlet weak var vSlider: UIView!
    @IBOutlet weak var vLeftSlider: UIView!
    @IBOutlet weak var vTitleSlider: UIView!
    @IBOutlet weak var vCircle: UIViewExtension!
    @IBOutlet weak var txDistance: UILabel!
    @IBOutlet weak var txLocation: UILabel!

    @IBOutlet weak var btnSearch: UIButtonExtension!
    @IBOutlet weak var bottomViewSlider: NSLayoutConstraint!
    @IBOutlet weak var heightVCircle: NSLayoutConstraint!
    @IBOutlet weak var widthVCircle: NSLayoutConstraint!
    
    var zoomMap:Float = 14
    var mapView:GMSMapView!
    lazy var mapViewModel:MapViewModel! = MapViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitailUI()
        setInitialObjects()
        callServiceMapPlace()
    }
    
    func setInitialObjects(){
        
        mapView = GMSMapView()
        mapView.delegate = self
    }
    
    func setInitailUI(){
        
        addGoogleMapView(zoom: zoomMap,userLocation: true)
        
        btnSearch.titleLabel?.text = .txBtnSearch
        txSlider.text = .txTitleSlider
        
        vTitleSlider.backgroundColor = UIColor.colorStrikemaster
        vTitleSlider.backgroundColor = UIColor.colorCharcoal
        
        btnSearch.backgroundColor = UIColor.colorRed
    }
    
    func addGoogleMapView(zoom:Float,userLocation:Bool){
        
        let camera = GMSCameraPosition.camera(withLatitude:mapViewModel.getZoomLocation(userLocation: userLocation)[0], longitude:mapViewModel.getZoomLocation(userLocation: userLocation)[1], zoom: zoom)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: Constant.DEVICE_W, height: Constant.DEVICE_H-110), camera:camera)
        
        self.view.addSubview(mapView)
        self.view.insertSubview(mapView, belowSubview: vFooter)
        self.view.insertSubview(mapView, belowSubview: vPin)
        self.view.insertSubview(mapView, belowSubview: vCircle)
    }
    
    @IBAction func btnSearchPressed(_ sender: Any) {
        callServiceMapPlace()
    }
    
    func callServiceMapPlace(){
        
        showLoading()
        btnSearch.loadingIndicator(show: true)
        btnSearch.isUserInteractionEnabled = false
        slider.isUserInteractionEnabled = false
        
        UserDefaults.standard.set(["lat":centerMarkerLocation().0,"lng":centerMarkerLocation().1],forKey:.userSelectedLocation)
        mapViewModel.callService(location: "\(centerMarkerLocation().0),\(centerMarkerLocation().1)", radius: mapViewModel.getRadiusFromSliderValue(sliderValue: slider.value), key: .GOOGLE_API)
    }
    
    func animationCircle(alpha:CGFloat){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.vCircle.alpha = alpha
        })
    }
    
    func centerMarkerLocation() -> (Double,Double) {
        
        let point:CGPoint = vPin.center
        let coor:CLLocationCoordinate2D = (mapView?.projection.coordinate(for: point))!
        
        let location = mapViewModel.validateCenterMarker(lat: coor.latitude, lng: coor.longitude)

        return (location[0],location[1])
    }
    
    @IBAction func sliderHandlerChangeState(_ sender: Any) {
        
        animationCircle(alpha: 0.2)
        txLocation.isHidden = false
        txLocation.text = String(format: "lat: %4f, lng %4f",centerMarkerLocation().0,centerMarkerLocation().1)
        txDistance.text = mapViewModel.distanceValueText(sliderValue: slider.value)
        mapView?.clear()
        mapView.removeFromSuperview()
        zoomMap = mapViewModel.zoomCamera(sliderValue: slider.value)
        addGoogleMapView(zoom: zoomMap,userLocation: false)
    }
    
    @IBAction func sliderHandlerDoneWithSender(_ sender: Any) {
        animationCircle(alpha: 0.1)
    }
    
    override func onDataDidLoad() {
        
        finishedLoading()
        
        mapView?.clear()
        addGoogleMapView(zoom: zoomMap,userLocation: false)
        
        let count = mapViewModel.getPlaceCount()
        
        mapViewModel.realmObjects.removeMapObjects()
        
        for i in 0...count {
            
            let lat = mapViewModel.getPlacesLocationLatLng(at: i, key: "lat")
            let lng = mapViewModel.getPlacesLocationLatLng(at: i, key: "lng")
            let name = mapViewModel.getPlacesObjects(at: i, key: "name")
            let image = mapViewModel.getPlacesImage(at: i)
            let distance = mapViewModel.getCalculateDistance(lat: lat, lng: lng)
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
            var icon:UIImage = UIImage(named: mapViewModel.getArrayMarker())!.withRenderingMode(.alwaysOriginal)
            icon = self.resizeImage(image:icon,width: 35,height:35)
            marker.icon = icon
            marker.title = name
            marker.snippet = .distanceText + " \(distance)"
            marker.map = mapView

            mapViewModel.setMapObjects(id:i, name: name, lat: lat, lng: lng, image: image, distance: distance)
        }
    }
    
    override func onDataDidLoadErrorWithMessage(errorMessage: String) {
        
        finishedLoading()
        showAlertPopup(title: .errorTitle, message: errorMessage, yes_text: .ok)
    }
    
    func finishedLoading(){
        
        hideLoading()
        
        txLocation.isHidden = true
        animationCircle(alpha: 0.0)
        btnSearch.loadingIndicator(show: false)
        btnSearch.isUserInteractionEnabled = true
        slider.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.clear()
        mapView.removeFromSuperview()
    }
}
