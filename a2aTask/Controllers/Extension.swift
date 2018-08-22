//
//  Extinstion.swift
//  a2aTask
//
//  Created by Ahmad Sallam  on 8/16/18.
//  Copyright © 2018 Ahmad Sallam . All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UITableView {
    
    func setEmptyMessage(message: String!, count: Int) {
        
        if count != 0 {
            restore()
            return
        }
        
        let bView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        bView.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.tag = 166
        messageLabel.sizeToFit()
        messageLabel.center = bView.center
        bView.addSubview(messageLabel)
        
        backgroundView = bView
        separatorStyle = .none
    }
    
    func restore() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}


extension UIView {
    
    
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }
    
    func addAlignedConstrains() {
        translatesAutoresizingMaskIntoConstraints = false
        addAlignConstraintToSuperview(attribute: NSLayoutAttribute.top)
        addAlignConstraintToSuperview(attribute: NSLayoutAttribute.leading)
        addAlignConstraintToSuperview(attribute: NSLayoutAttribute.trailing)
        addAlignConstraintToSuperview(attribute: NSLayoutAttribute.bottom)
    }
    
    func addAlignConstraintToSuperview(attribute: NSLayoutAttribute) {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: NSLayoutRelation.equal,
                toItem: superview,
                attribute: attribute,
                multiplier: 1,
                constant: 0
            )
        )
    }
    
    private (set) var blurView: BlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName
                ) as? BlurView {
                return blurView
            }
            self.blurView = BlurView(to: self)
            return self.blurView
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

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
        
        alert.addAction(UIAlertAction(title: ok, style: UIAlertActionStyle.default, handler:handler))
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
