//
//  AlertManager.swift
//  Homingos
//
//  Created by Ankit Angra on 04/10/17.
//  Copyright © 2017 Homingos. All rights reserved.
//

import UIKit


import Foundation


extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return
                regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    //validate PhoneNumber
    var isPhoneNumber: Bool {
        let charcter  = CharacterSet.init(charactersIn: "+0123456789").inverted
        var filtered = ""
        let inputString = components(separatedBy: charcter)
        filtered = inputString.joined(separator: "")
        return  self == filtered
    }
}

class AlertManager {
    
    class func showAlert(inViewController vc : UIViewController,withTitle title : String, message : String, cancelButtonTitle : String? = nil, destructiveButtonTitle : String? = nil, otherButtonTitles : [String]? = nil ,completion : ((Int) -> ())? = nil, cancelCompletion : (() -> ())? = nil ) {
        
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        ActivityIndicatorManager.dismissActivityIndicator()
        
        if let cancelButton = cancelButtonTitle {
            if cancelButton.isBlank == false {
                // let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: .cancel, handler: nil)
                
                let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: .cancel, handler: { (action) in
                    cancelCompletion? ()
                })
                alertVC.addAction(cancelAction)
            }
        }
        
        if let desctictiveButton = destructiveButtonTitle {
            if desctictiveButton.isBlank == true {
                let desctructiveAction = UIAlertAction.init(title: cancelButtonTitle, style: .destructive, handler: nil)
                alertVC.addAction(desctructiveAction)
            }
        }
        
        if let otherButton = otherButtonTitles {
            for (index, item) in otherButton.enumerated() {
                let action = UIAlertAction.init(title: item, style: .default, handler: { action in
                    
                    if let completion = completion {
                        completion (index)
                    }
                })
                alertVC.addAction(action)
            }
        }
        
        if alertVC.actions.count == 0 {
            let cancelAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
        }
        
        vc.present(alertVC, animated: true, completion: nil)
    }
}


