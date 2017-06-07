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

    @IBOutlet weak var vSelectedMenuMap: UIView!
    @IBOutlet weak var vSelectedMenuSearch: UIView!

    override func awakeFromNib() {
        self.frame = CGRect(x: 0, y: 0, width: Constant.DEVICE_W, height: self.frame.size.height)
    }
}
