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
    
    var mapView:GMSMapView!
    
    var mapViewModel:MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitailUI()
        setInitialObjects()
    }
    
    func setInitialObjects(){
        
        mapView = GMSMapView()
        mapViewModel = MapViewModel()
    }
    
    func setInitailUI(){
        
        addGooleMapView(zoom: 1)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        vFooter.addGestureRecognizer(gestureRecognizer)
        
        btnSearch.titleLabel?.text = .txBtnSearch
        txSlider.text = .txTitleSlider
        
        vTitleSlider.backgroundColor = UIColor.colorStrikemaster
        vTitleSlider.backgroundColor = UIColor.colorCharcoal
        
        btnSearch.backgroundColor = UIColor.colorRed
        
    }
    
    func addGooleMapView(zoom:Float){
        
        let camera = GMSCameraPosition.camera(withLatitude: 18.790240, longitude: 98.984865, zoom: zoom)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: Constant.DEVICE_W, height: Constant.DEVICE_H-110), camera:camera)
        
        self.view.addSubview(mapView!)
        self.view.insertSubview(mapView!, belowSubview: vFooter)
        self.view.insertSubview(mapView!, belowSubview: vPin)
        self.view.insertSubview(mapView!, belowSubview: vCircle)
    }
    
    @IBAction func btnSearchPressed(_ sender: Any) {
        
        showLoading()
        
        let point:CGPoint = (mapView?.center)!
        let coor:CLLocationCoordinate2D = (mapView?.projection.coordinate(for: point))!
        
        let chooselat:Double = coor.latitude
        let chooselng:Double = coor.longitude
        
        print("lat lng",chooselat,chooselng)
        hideLoading()
    }
    
    @IBAction func vSliderTapped(_ sender: Any) {
        animationFooter(constant: mapViewModel.sizeForBottomOfViewSliderFromTapGesture(constant: self.bottomViewSlider.constant))
    }
    
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let velocity : CGPoint =  gestureRecognizer.velocity(in:vSlider)
            animationFooter(constant: mapViewModel.sizeForBottomOfViewSliderFromPanGesture(velocityY: velocity.y))
        }
    }
    
    func animationFooter(constant:CGFloat){
        
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.bottomViewSlider.constant = constant
            self.view.layoutIfNeeded()
        })
    }
    
    func animationCircle(alpha:CGFloat){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.vCircle.alpha = alpha
        })
    }
    
    @IBAction func sliderHandlerChangeState(_ sender: Any) {
        
        animationCircle(alpha: 0.1)
        txDistance.text = mapViewModel.distanceValueText(sliderValue: slider.value)
    }
    
    @IBAction func sliderHandlerDoneWithSender(_ sender: Any) {
        
        animationCircle(alpha: 0.3)
        mapView?.clear()
        
        addGooleMapView(zoom: mapViewModel.zoomCamera(sliderValue: slider.value))
    }
}
