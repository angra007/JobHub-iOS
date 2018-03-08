//
//  ActivityIndicatorManager.swift
//  phostagram-ios
//
//  Created by Ankit Angra on 27/09/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit
import SVProgressHUD

class ActivityIndicatorManager {
    
    static let tag = 1000221
    
    class func showActivityIndicator () {
        SVProgressHUD.show()
    }
    
    class func showActivityIndicator (inViews view : UIView) {
        SVProgressHUD.show()
        SVProgressHUD.setContainerView(view)
    }
    
    class func dismissActivityIndicator () {
        SVProgressHUD.dismiss()
    }
    
    class func dismissActivityIndicator (fromView view : UIView) {
        SVProgressHUD.dismiss()
    }
}
