//
//  ContactViewModel.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Firebase

protocol ViewModelDelegate : class {
    func reload ()
    func didReceiveError (withMessage message : String)
}

class ContactsViewModel :NSObject {
    
    fileprivate var context : NSManagedObjectContext!
    var contacts = [Character: [Contact]] ()
    var filteredText = ""
    
    var peoples = [People] ()
    fileprivate var unformattedContacts = [Contact] ()
    
    fileprivate weak var delegate : ViewModelDelegate?
    
    init (delegate : ViewModelDelegate) {
        self.delegate = delegate
    }
    
    // Methods to Access Contacts
    func numberOfSection () -> Int {
        return 1 //datasource.count
    }
    
    func numberOfRows (inSectionIndex index : Int) -> Int {
        return  peoples.count
    }
    
    func contactAtIndex (atIndex section : Int, row : Int) -> People {
        return peoples [row]
    }
    
    func getContacts (withCompletion completion : @escaping (Bool) -> ()) {
        let reference = RequestType.contacts.reference
        NetworkManager.getValueForSingleEvent(forReference: reference) { (response) in
            if let snap = response as? DataSnapshot {
                if let value = snap.value as? [String : AnyObject] {
                    if let contactsID = value ["accepted"] as? [String] {
                        var count = 0
                        
                        for (_,c) in contactsID.enumerated() {
                            let userID = c
                            let reference = RequestType.users.reference.child(userID)
                            NetworkManager.getValueForSingleEvent(forReference: reference, completion: { (result) in
                                if let snap = result as? DataSnapshot {
                                    if var value = snap.value as? [String : AnyObject] {
                                        print(value)
                                        value ["id"] = userID as AnyObject
                                        let people = People.init(withJson: value as [String : AnyObject])
                                        self.peoples.append(people)
                                    }
                                }
                                count = count + 1
                                if count == contactsID.count {
                                    completion (true)
                                }
                            })
                        }
                        
                    }
                }
            }
        }
    }
}
