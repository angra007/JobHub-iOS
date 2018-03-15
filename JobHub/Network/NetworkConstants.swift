//
//  NetworkConstants.swift
//  SurfSharing
//
//  Created by Ankit Angra on 03/11/17.
//  Copyright © 2017 Surf Sharing. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

typealias WebRequestCompletionHandler = (Any?) -> Void

let BASE_REFERENCE = Database.database().reference()
let STORAGE_REFERENCE = Storage.storage().reference()


enum RequestType {
    
    case profile
    case job
    case lift
    case licenceImage
    
    var reference : DatabaseReference {
        switch self {
        case .profile:
            return BASE_REFERENCE.child("users").child(Auth.auth().currentUser!.uid)
        case .job:
            return BASE_REFERENCE.child("jobs")
        case .lift:
            return BASE_REFERENCE.child("lifts")
            
        case .licenceImage:
            return BASE_REFERENCE.child("users").child(Auth.auth().currentUser!.uid).child("licenceImage")
        }
    }
}

