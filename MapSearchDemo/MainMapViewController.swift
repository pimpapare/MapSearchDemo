//
//  MainMapViewController.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import GoogleMaps

class MainMapViewController: BaseViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var vStatusBar: UIView!
    @IBOutlet weak var containerMap: UIView!
    @IBOutlet weak var containerSearch: UIView!
    
    var headerView:HeaderView?
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserLocation()
        setInitialUI()
    }
    
    func setUserLocation(){
        
        locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        UserDefaults.standard.set(["lat":Double(locValue.latitude),"lng":Double(locValue.longitude)],forKey:.userLocation)
        locationManager.stopUpdatingLocation()
    }
    
    func setInitialUI(){
        
        vStatusBar.backgroundColor = UIColor.colorCharcoal
        
        headerView = (Bundle.main.loadNibNamed("HeaderView", owner: nil, options: nil)?[0] as? HeaderView)!
        headerView?.btnMenuMap.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        headerView?.btnMenuSearch.addTarget(self, action: #selector(openSearch), for: .touchUpInside)
        self.view.addSubview(headerView!)
        
        setUIMenu(viewMap: 1, viewSearch: 0)
    }
    
    func openMap(_ sender: Any) {
        setUIMenu(viewMap: 1, viewSearch: 0)
    }
    
    func openSearch(_ sender: Any) {
        NotificationCenter.default.post(name: .updateCell, object: nil)
        setUIMenu(viewMap: 0, viewSearch: 1)
    }
    
    func setUIMenu(viewMap:CGFloat,viewSearch:CGFloat){
        
        self.containerMap.alpha = viewMap
        self.containerSearch.alpha = viewSearch
    }
}
