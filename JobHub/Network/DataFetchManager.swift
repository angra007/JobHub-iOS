//
//  DataFetchManager.swift
//  SurfSharing
//
//  Created by Ankit Angra on 03/11/17.
//  Copyright © 2017 Surf Sharing. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class NetworkManager {
    
    static let currentID = Auth.auth().currentUser!.uid
    
    class func handleAPIError () {
        let rootVC = UIApplication.shared.keyWindow!.rootViewController
        AlertManager.showAlert(inViewController: rootVC!, withTitle: "", message: "Something went wrong. Please try again")
    }
    
    class func handleAPIError (withString string : String) {
        let rootVC = UIApplication.shared.keyWindow!.rootViewController
        AlertManager.showAlert(inViewController: rootVC!, withTitle: "", message: string)
    }
    
    class func login (withEmail email : String, password : String, completion:  @escaping WebRequestCompletionHandler) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                handleAPIError(withString: error!.localizedDescription)
                completion (nil)
            }
            else {
                completion (user)
            }
        }
    }
    
    class func register (withEmail email : String, password : String, completion:  @escaping WebRequestCompletionHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                handleAPIError(withString: error!.localizedDescription)
                completion (nil)
            }
            else {
                completion (user)
            }
        }
    }
    
    class func updateInformation (forRequestType type : RequestType, values : [String : AnyObject], completion:  @escaping WebRequestCompletionHandler) {
        print(values)
        type.reference.updateChildValues(values) { (error, databaseReference) in
            if error != nil {
                handleAPIError()
                completion (nil)
            }
            else {
                completion (databaseReference)
            }
        }
    }
    
    class func updateInformation (forReference reference : DatabaseReference,values : [String : AnyObject],completion:  @escaping WebRequestCompletionHandler ) {
        reference.updateChildValues(values) { (error, databaseReference) in
            if error != nil {
                handleAPIError()
                completion (nil)
            }
            else {
                completion (databaseReference)
            }
        }
    }
    
    class func getAllValues (forRequestType type :RequestType, completion:  @escaping WebRequestCompletionHandler ) {
        type.reference.observeSingleEvent(of: .value, with: { (snapShot) in
            completion (snapShot)
        }) { (error) in
            handleAPIError()
            completion (nil)
        }
    }
    
    class func getAllValues (forReference reference : DatabaseReference,completion:  @escaping WebRequestCompletionHandler ) {
        reference.observe(.value, with: { (snapShot) in
            completion (snapShot)
        }) { (error) in
            handleAPIError()
            completion (nil)
        }
    }
    
    
    class func child (forReference reference : DatabaseReference,completion:  @escaping WebRequestCompletionHandler ) {
        reference.observe(.childAdded, with: { (snapShot) in
            completion (snapShot)
        }) { (error) in
            handleAPIError()
            completion (nil)
        }
    }
    
    class func getValueForSingleEvent (forReference reference : DatabaseReference,completion:  @escaping WebRequestCompletionHandler ) {
        reference.observeSingleEvent(of: .value, with: { (snapShot) in
            completion (snapShot)
        }) { (error) in
            handleAPIError()
            completion (nil)
        }
    }
    
    class func setValue ( _ value : Any,  type :RequestType ,completion:  @escaping WebRequestCompletionHandler) {
        type.reference.setValue(value) { (error, reference) in
            if error != nil {
                handleAPIError()
                completion (nil)
            }
            else {
                completion (reference)
            }
        }
    }
    
    
}
