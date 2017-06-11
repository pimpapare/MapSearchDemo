//
//  BaseProtocol.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import Foundation

public protocol BaseViewModelDelegate: class {
    
    // Load data
    func onDataDidLoad()
    func onDataDidLoadErrorWithMessage(errorMessage:String)

    func onImageDataDidLoad()

    func refrashCollectionView()

    // Loading
    func showLoading()
    func hideLoading()
}
