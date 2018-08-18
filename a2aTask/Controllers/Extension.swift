//
//  Extinstion.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/16/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit
import NVActivityIndicatorView


extension UIViewController {
    
    func showAlert(title: String!, message: String!, ok: String!){
        let alert = UIAlertController(title: title ?? "Alert",
                                      message: message,
                                      preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ok ?? "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertWithHandler(title: String!, message: String!, ok: String!,handler:((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title ?? "Alert",
                                      message: message,
                                      preferredStyle:UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "test", style: UIAlertActionStyle.default, handler:handler))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showActivityIndicator(message: String? = nil){
        NVActivityIndicatorView.DEFAULT_TYPE = .ballScaleRippleMultiple
        let activityData = ActivityData(size: nil,
                                        message: message,
                                        messageFont: nil,
                                        messageSpacing: nil,
                                        type: nil,
                                        color: nil,
                                        padding: nil,
                                        displayTimeThreshold: nil,
                                        minimumDisplayTime: nil,
                                        backgroundColor: nil,
                                        textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
     func hideActivityIndicator(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}
