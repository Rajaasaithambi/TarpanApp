//
//  UIViewControllerExtension.swift
//  Tarpan
//
//  Created by Praveen P on 8/12/16.
//  Copyright © 2016 minuscale. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(_ title: String?, message: String!, okTitle: String! = "OK", okCallBack:(() -> Void)? = nil, cancelTitle:String? = nil,cancelCallBack:(()-> Void)? = nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert);
        
        alertController.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) -> Void in
            okCallBack?();
        }));
        if (cancelTitle != nil)
        {
            alertController.addAction(UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction) -> Void in
                cancelCallBack?();
            }));
        }
        self.present(alertController, animated: true, completion: nil);
    }
}
