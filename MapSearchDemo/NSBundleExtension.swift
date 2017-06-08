//
//  NSBundleExtension.swift
//  SwiftFastLandDemo
//
//  Created by pimpaporn chaichompoo on 11/21/16.
//  Copyright © 2016 Pimpaporn Chaichompoo. All rights reserved.
//

import Foundation

public extension Bundle {
    
    /// Usage: let view: ViewXibName = NSBundle.loadNib("ViewXibName")
    public class func loadNib<NibName>(name: String) -> NibName? {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?[0] as? NibName
    }

}
