//
//  UIViewController + Extension.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import Foundation
import SVProgressHUD

extension UIViewController {
    
    //---Activity Indicator
    func showActivityIndicator() {
        SVProgressHUD.dismiss()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.init(rawValue: 2)!)
        SVProgressHUD.show()
    }

    //---Hide Activity Indicator
    func hideActivityIndicator() {
        SVProgressHUD.dismiss()
    }
    
}
