//
//  UIViewExtension.swift
//  IndiaSulekha6.3.2
//
//  Created by Praveen Parthasarathy on 6/14/16.
//  Copyright © 2016 karthikps. All rights reserved.
//

import Foundation
import UIKit



public extension UIView {
    
    public func setConstraint(_ attribute: NSLayoutAttribute,value: Float) {
        var constraint: NSLayoutConstraint? = nil;
        constraint = self.constraints.filter{ $0.firstAttribute == NSLayoutAttribute.height }.first
        constraint?.constant = CGFloat(value);
    }
    
    
    
    public var heightConstraint : CGFloat? {
        get {
            let constraint = self.constraints.filter{ $0.firstAttribute == NSLayoutAttribute.height }.first
            return constraint?.constant
        }
        set (newValue) {
            let constraint = self.constraints.filter{ $0.firstAttribute == NSLayoutAttribute.height }.first
            if let nonNilValue = newValue {
                constraint?.constant = nonNilValue;
            }
        }
    }

    
    
//    lazy var contentLoadingView: UIContentLoadingIndicatorView? = {
//        
//        let pageLoadingView = NSBundle.mainBundle().loadNibNamed("ContentLoadingView", owner: self, options: nil)[0] as? UIContentLoadingIndicatorView;
//        // To resize
//        
//        return pageLoadingView;
//    }();
    
    func showLoadingView() {
        
        var contentLoadingView: UIContentLoadingIndicatorView? =  nil;
        
        contentLoadingView = (self.subviews.filter{ $0 is UIContentLoadingIndicatorView }.first as? UIContentLoadingIndicatorView)
        
        if contentLoadingView == nil {
            contentLoadingView = Bundle.main.loadNibNamed("ContentLoadingView", owner: self, options: nil)?[0] as? UIContentLoadingIndicatorView;
            if let loadingView = contentLoadingView {
                self.addSubview(loadingView);
            }
        }
            
        if let loadingView = contentLoadingView {
            loadingView.center = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2);
            self.bringSubview(toFront: loadingView);
            loadingView.startAnimating();
        }
    }
    
    func hideLoadingView() {
        
        guard let contentLoadingView: UIContentLoadingIndicatorView = (self.subviews.filter{ $0 is UIContentLoadingIndicatorView }.first as? UIContentLoadingIndicatorView) else {
            return;
        }
        contentLoadingView.stopAnimating();
    }

    
}
