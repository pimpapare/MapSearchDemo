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
        
        setMenuMapView()

        txHeader.text = .txTitleHeader
        
        btnMenuMap.setTitle(.txBtnMap, for: .normal)
        btnMenuSearch.setTitle(.txBtnSearch, for: .normal)

        vTitle.backgroundColor = UIColor.colorCharcoal
        btnMenuMap.backgroundColor = UIColor.colorWhiteSmoke
        btnMenuSearch.backgroundColor = UIColor.colorWhiteSmoke
    }
    
    @IBAction func btnMenuMapTapped(_ sender: Any) {
        setMenuMapView()
    }

    func setMenuMapView(){
        self.resetViewTapped()
        self.vSelectedMenuMap.backgroundColor = UIColor.colorStrikemaster
    }
    
    @IBAction func btnMenuSearchTapped(_ sender: Any) {
        self.resetViewTapped()
        self.vSelectedMenuSearch.backgroundColor = UIColor.colorStrikemaster
    }
    
    func resetViewTapped(){
        self.vSelectedMenuMap.backgroundColor = UIColor.colorCharcoal
        self.vSelectedMenuSearch.backgroundColor = UIColor.colorCharcoal
    }
}
