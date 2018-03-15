//
//  Contact.swift
//  Radar Locator
//
//  Created by Ankit Angra on 12/11/17.
//  Copyright © 2017 Radar Labs Pvt Ltd. All rights reserved.
//

import UIKit
import CoreData

class Contact: NSManagedObject {
    @NSManaged fileprivate(set) var statusMessage : String?
    @NSManaged fileprivate(set) var registeredName : String?
    @NSManaged fileprivate(set) var isTrusted : Bool
    @NSManaged fileprivate(set) var isContact : Bool
    @NSManaged fileprivate(set) var isUser : Bool
    @NSManaged fileprivate(set) var isBlocked : Bool
    @NSManaged fileprivate(set) var imageTag : String?
    @NSManaged fileprivate(set) var contactID : String!
    @NSManaged fileprivate(set) var phoneNumber : String!
    @NSManaged fileprivate(set) var formattedNumber : String!
    @NSManaged fileprivate(set) var thumnailImage : Data?
    @NSManaged fileprivate(set) var profileImage : Data?
    @NSManaged fileprivate(set) var displayName : String!
    @NSManaged fileprivate(set) var type : String!
    
    static func insert(into context: NSManagedObjectContext, withData data : [String : Any]) -> Contact {
        
        let number = data ["phoneNumber"] as! String
        let predicate = NSPredicate(format: "%K CONTAINS[C] %@", #keyPath(phoneNumber), number)
        
        return Contact.findOrCreate(in: context, matching: predicate, configure: { (contact) in
            contact.statusMessage = data ["statusMessage"] as? String
            contact.registeredName = data ["registeredName"] as? String
            
            if let isTrusted =  data ["isTrusted"] as? Bool {
                contact.isTrusted = isTrusted
            }
            
            if let isContact =  data ["isContact"] as? Bool {
                contact.isContact = isContact
            }
            
            if let isUser =  data ["isUser"] as? Bool {
                contact.isUser = isUser
            }
            
            if let isBlocked =  data ["isBlocked"] as? Bool {
                contact.isBlocked = isBlocked
            }
            contact.imageTag = data ["imageTag"] as? String
            contact.contactID = data ["contactID"] as? String
            contact.phoneNumber = data ["phoneNumber"] as! String
            contact.formattedNumber = data ["formattedNumber"] as? String

            contact.thumnailImage = data ["thumnailImage"] as? Data
            contact.profileImage = data ["profileImage"] as? Data
            contact.displayName = data ["displayName"] as? String
            contact.type = data ["type"] as? String
            
        })
    }
    
    static func markAsBlocked (in context: NSManagedObjectContext, contact : Contact) {
        contact.isBlocked = true
        _ = context.saveOrRollback()
    }
    
    static func markAsUnBlocked (in context: NSManagedObjectContext, contact : Contact) {
        contact.isBlocked = false
        _ = context.saveOrRollback()
    }
    
    static func disable (in context: NSManagedObjectContext, contact : Contact) {
        contact.isUser = false
        contact.registeredName = nil
        contact.imageTag = nil
        contact.statusMessage = nil
        _ = context.saveOrRollback()
    }
    
    static func updateData (in context: NSManagedObjectContext, contact : Contact, registeredName : String?, imageTag : String?, statusMessage : String?) {
        contact.registeredName = registeredName
        contact.imageTag = imageTag
        contact.statusMessage = statusMessage
        _ = context.saveOrRollback()
    }
}


extension Contact: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(displayName), ascending: true)]
    }
}
