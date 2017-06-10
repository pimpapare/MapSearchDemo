//
//  HeaderView.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var txHeader: UILabel!
    @IBOutlet weak var btnMenuMap: UIButton!
    @IBOutlet weak var btnMenuSearch: UIButton!

    @IBOutlet weak var vTitle: UIView!
    @IBOutlet weak var vSelectedMenuMap: UIView!
    @IBOutlet weak var vSelectedMenuSearch: UIView!

    override func awakeFromNib() {
        self.frame = CGRect(x: 0, y: 20, width: Constant.DEVICE_W, height: self.frame.size.height)
        setInitail()
    }
    
    func setInitail(){
        
        txHeader.text = .txTitleHeader
        
        btnMenuMap.setTitle(.txBtnMap, for: .normal)
        btnMenuSearch.setTitle(.txBtnSearch, for: .normal)

        vTitle.backgroundColor = UIColor.colorStrikemaster
        btnMenuMap.backgroundColor = UIColor.colorCharcoal
        btnMenuSearch.backgroundColor = UIColor.colorCharcoal
        self.vSelectedMenuMap.backgroundColor = UIColor.colorWhiteSmoke
        self.vSelectedMenuSearch.backgroundColor = UIColor.colorWhiteSmoke
        
        setMenuMapView()
    }
    
    @IBAction func btnMenuMapTapped(_ sender: Any) {
        setMenuMapView()
    }

    func setMenuMapView(){
        self.resetViewTapped(vSelectedMenuMapAlpha: 0.6, vSelectedMenuSearchAlpha: 0)
    }
    
    @IBAction func btnMenuSearchTapped(_ sender: Any) {
        self.resetViewTapped(vSelectedMenuMapAlpha: 0, vSelectedMenuSearchAlpha: 0.6)
    }
    
    func resetViewTapped(vSelectedMenuMapAlpha:CGFloat,vSelectedMenuSearchAlpha:CGFloat){
        self.vSelectedMenuMap.alpha = vSelectedMenuMapAlpha
        self.vSelectedMenuSearch.alpha = vSelectedMenuSearchAlpha
    }
}
