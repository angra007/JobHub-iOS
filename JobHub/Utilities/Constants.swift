//
//  Constants.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation

enum PrivacyLevel : Int {
    case everyone
    case contacts
    case nobody
    
    var title : String {
        switch self {
        case .everyone:
            return "Everyone"
        case .contacts:
            return "My Contacts"
        case .nobody:
            return "Nobody"
        }
    }
    
    var value : String {
        switch self {
        case .everyone:
            return "Everyone"
        case .contacts:
            return "My contacts"
        case .nobody:
            return "Nobody"
        }
    }
}

enum SelectPrivacyNavigationType {
    case none
    case photo
    case status
    
    var title : String {
        switch self {
        case .none:
            return ""
        case .photo:
            return "Profile Photo"
        case .status:
            return "Status"
        }
    }
}
