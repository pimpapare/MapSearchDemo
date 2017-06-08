//
//  BaseViewController.swift
//  MapSearchDemo
//
//  Created by pimpaporn chaichompoo on 6/8/17.
//  Copyright © 2017 Pimpaporn Chaichompoo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// Usage: gotoStoryClass("ViewClassName")
    func gotoStoryClass(classname:String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:classname)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    /// Usage: gotoNibClass(className: "LoginView")
    func gotoNibClass(className:String) {
        self.navigationController?.pushViewController(Bundle.loadNib(name:className)!, animated: true)
    }

    /// Usage: self.showAlertPopup(title: " ", message: " ", yes_text: " ")
    func showAlertPopup(title: String, message: String, yes_text: String) {
        
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: yes_text, style: .default, handler:nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
