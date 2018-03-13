//
//  File.swift
//  Sloggers
//
//  Created by Ankit Angra on 05/02/17.
//  Copyright © 2017 NewMediaTechies. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum StoryboardIdentifiers : String {
        case JobTitleController = "jobTitleVC"
        case JobIndustryController = "jobIndustryVC"
        case JobLocationController = "jobLocationVC"
        case JobSearchController = "jobSearchVC"
        case JobTabBarController = "jobHomeViewController"
        
        case ChatListingController = "chatListingVC"
        
        case SettingsLandingController = "settingLandingVC"
        case AccountController = "accountVC"
        case PrivacyController = "privacyVC"
        case SelectPrivacyController = "selectPrivacyVC"
        case ChangePhoneNumberController = "changePhoneNumberController"
        case DeleteAccountController = "delectAccountVC"
        
        case ContactsListingController = "contactsListingController"
        
    }
    // LoginStoryboard
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func homeStoryboard () -> UIStoryboard {
        return UIStoryboard(name: "HomeStoryboard", bundle: Bundle.main)
    }
    
    class func chatStoryboard () -> UIStoryboard {
        return UIStoryboard(name: "ChatStoryboard", bundle: Bundle.main)
    }
    
    class func settingsStoryboard () -> UIStoryboard {
        return UIStoryboard(name: "SettingsStoryboard", bundle: Bundle.main)
    }
    
    class func contactsStoryboard () -> UIStoryboard {
        return UIStoryboard(name: "ContactsStoryboard", bundle: Bundle.main)
    }

}
