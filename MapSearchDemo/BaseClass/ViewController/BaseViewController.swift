//
//  BaseViewController.swift
//  NongBeer
//
//  Created by Thongpak on 4/6/2560 BE.
//  Copyright © 2560 Thongpak. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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


extension BaseViewController: BaseViewModelDelegate {
    public func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    public func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    public func onDataDidLoad() {
        
    }
    
    public func onDataDidLoadErrorWithMessage(errorMessage: String) {
        
    }
}
