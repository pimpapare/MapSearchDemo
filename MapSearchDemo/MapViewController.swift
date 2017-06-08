//
//  MapViewController.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var txSlider: UILabel!
    @IBOutlet weak var slider: UISlider!

    @IBOutlet weak var vFooter: UIView!
    @IBOutlet weak var vSlider: UIView!
    @IBOutlet weak var vLeftSlider: UIView!
    @IBOutlet weak var vTitleSlider: UIView!

    @IBOutlet weak var btnSearch: UIButtonExtension!
    @IBOutlet weak var bottomViewSlider: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setInitailUI()
    }

    func setInitailUI(){
    
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        vFooter.addGestureRecognizer(gestureRecognizer)
        
        btnSearch.titleLabel?.text = .txBtnSearch
        txSlider.text = .txTitleSlider
        
        vTitleSlider.backgroundColor = UIColor.colorStrikemaster
        vTitleSlider.backgroundColor = UIColor.colorCharcoal
        
        btnSearch.backgroundColor = UIColor.colorWhiteSmoke
    }
    
    @IBAction func btnSearchPressed(_ sender: Any) {
  
    }
    
    func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let velocity : CGPoint =  gestureRecognizer.velocity(in:vSlider)
            if velocity.y < 0 {
                animation(constant: 0)
            }else{
                animation(constant: -75)
            }
        }
    }
    
    func animation(constant:CGFloat){
        
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            self.bottomViewSlider.constant = constant
            self.view.layoutIfNeeded()
        }) { _ in
        }
    }
    
}
