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
    
    func resizeImage(image: UIImage, width: Int,height:Int) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:width,height:height), false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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
    
    func onImageDataDidLoad() {

    }

    public func onDataDidLoadErrorWithMessage(errorMessage: String) {
        
    }

    public func refrashCollectionView() {
        
    }
}
