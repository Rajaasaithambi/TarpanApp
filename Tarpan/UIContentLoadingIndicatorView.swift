//
//  UILoadingIndicatorView.swift
//  IndiaSulekha6.3.2
//
//  Created by Praveen Parthasarathy on 6/14/16.
//  Copyright © 2016 karthikps. All rights reserved.
//

import UIKit

open class UIContentLoadingIndicatorView: UIView {
    
    //    /*
    //    // Only override drawRect: if you perform custom drawing.
    //    // An empty implementation adversely affects performance during animation.
    //    override func drawRect(rect: CGRect) {
    //        // Drawing code
    //    }
    //    */
    //
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect);
        self.activityBackgroudView?.layer.cornerRadius = 3;
    }
    
    @IBOutlet weak var pageLoadingActivity: UIActivityIndicatorView?;
    @IBOutlet weak var activityBackgroudView: UIView?;
    //
    //    init?() {
    //        super.init(frame: CGRectMake(0, 0, 100, 100));
    //        return ;
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //        init
    //    }
    
    open  func startAnimating(maskEnabled maskBackground: Bool = false) {
        self.isHidden = false;
        self.pageLoadingActivity?.startAnimating();
        if maskBackground {
            self.backgroundColor = UIColor.white;
        }
        else {
            self.backgroundColor = UIColor.clear;
        }
    }
    
    open func stopAnimating() {
        self.isHidden = true;
        self.pageLoadingActivity?.stopAnimating();
    }
    
}
