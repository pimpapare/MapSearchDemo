//
//  MapViewController.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: BaseViewController {
    
    @IBOutlet weak var txSlider: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var vPin: UIView!
    @IBOutlet weak var vFooter: UIView!
    @IBOutlet weak var vSlider: UIView!
    @IBOutlet weak var vLeftSlider: UIView!
    @IBOutlet weak var vTitleSlider: UIView!
    @IBOutlet weak var vCircle: UIViewExtension!
    @IBOutlet weak var txDistance: UILabel!
    
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
    }
    
    func setInitailUI(){
        
        addGoogleMapView(zoom: zoomMap)
        
        btnSearch.titleLabel?.text = .txBtnSearch
        txSlider.text = .txTitleSlider
        
        vTitleSlider.backgroundColor = UIColor.colorStrikemaster
        vTitleSlider.backgroundColor = UIColor.colorCharcoal
        
        btnSearch.backgroundColor = UIColor.colorRed
    }
    
    func addGoogleMapView(zoom:Float){
        
        let camera = GMSCameraPosition.camera(withLatitude: mapViewModel.getUserLocation().0, longitude: mapViewModel.getUserLocation().1, zoom: zoom)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: Constant.DEVICE_W, height: Constant.DEVICE_H-110), camera:camera)
        
        self.view.addSubview(mapView!)
        self.view.insertSubview(mapView!, belowSubview: vFooter)
        self.view.insertSubview(mapView!, belowSubview: vPin)
        self.view.insertSubview(mapView!, belowSubview: vCircle)
    }
    
    @IBAction func btnSearchPressed(_ sender: Any) {
        callServiceMapPlace()
    }
    
    func callServiceMapPlace(){
        
        showLoading()
        btnSearch.loadingIndicator(show: true)
        btnSearch.isUserInteractionEnabled = false
        slider.isUserInteractionEnabled = false
        
        let point:CGPoint = (mapView?.center)!
        let coor:CLLocationCoordinate2D = (mapView?.projection.coordinate(for: point))!
        
        let chooselat:Double = coor.latitude
        let chooselng:Double = coor.longitude
        
        UserDefaults.standard.set(["lat":Double(chooselat),"lng":Double(chooselng)],forKey:.userSelectedLocation)
        mapViewModel.callService(location: "\((chooselat == -180.0) ? .defaultLat:chooselat),\((chooselng == -180.0) ? .defaultLng:chooselng)", radius: mapViewModel.getRadiusFromSliderValue(sliderValue: slider.value), key: .GOOGLE_API)
    }
    
    func animationCircle(alpha:CGFloat){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.vCircle.alpha = alpha
        })
    }
    
    @IBAction func sliderHandlerChangeState(_ sender: Any) {
        
        animationCircle(alpha: 0.3)
        txDistance.text = mapViewModel.distanceValueText(sliderValue: slider.value)

        mapView?.clear()
        mapView.removeFromSuperview()
        zoomMap = mapViewModel.zoomCamera(sliderValue: slider.value)
        addGoogleMapView(zoom: zoomMap)
    }
    
    @IBAction func sliderHandlerDoneWithSender(_ sender: Any) {
        
        animationCircle(alpha: 0.1)
    }
    
    override func onDataDidLoad() {
        
        finishedLoading()
        
        mapView?.clear()
        addGoogleMapView(zoom: zoomMap)
        
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
                        
            marker.map = mapView
            mapViewModel.setMapObjects(id:i, name: name, lat: lat, lng: lng, image: image, distance: distance)
        }
    }
    
    override func onDataDidLoadErrorWithMessage(errorMessage: String) {
        
    }
    
    func finishedLoading(){
        hideLoading()
        btnSearch.loadingIndicator(show: false)
        btnSearch.isUserInteractionEnabled = true
        slider.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.clear()
        mapView.removeFromSuperview()
    }
}
