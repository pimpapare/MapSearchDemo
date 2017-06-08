//
//  MainMapViewController.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit

class MainMapViewController: UIViewController {

    @IBOutlet weak var containerMap: UIView!
    @IBOutlet weak var containerSearch: UIView!
    
    var headerView:HeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
    }

    func setInitialUI(){
        
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
        setUIMenu(viewMap: 0, viewSearch: 1)
    }
    
    func setUIMenu(viewMap:CGFloat,viewSearch:CGFloat){
        
        self.containerMap.alpha = viewMap
        self.containerSearch.alpha = viewSearch
    }
}
