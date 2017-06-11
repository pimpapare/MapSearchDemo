//
//  EmptyView.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/9/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit
import EZSwiftExtensions

protocol EmptyViewDelegate: class {
    func didReload()
}

class EmptyView: UIView {
    
    weak var delegate: EmptyViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
