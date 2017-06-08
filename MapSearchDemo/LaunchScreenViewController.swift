//
//  ViewController.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.perform(#selector(goToMapStoryBoard), with: nil, afterDelay: 0.2)
    }

    func goToMapStoryBoard(){
        self.performSegue(withIdentifier: "goToMapStoryBoard", sender: nil)
    }
}

