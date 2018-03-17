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

protocol ViewModelDelegate : class {
    func reload ()
    func didReceiveError (withMessage message : String)
}

class ContactsViewModel :NSObject {
    
    class ContactListDatastructure {
        var initials : String!
        var contacts = [Contact] ()
        
        init(withInitials initials : String, contacts : [Contact]) {
            self.initials = initials
            self.contacts = contacts
        }
    }
    
    fileprivate var context : NSManagedObjectContext!
    var contacts = [Character: [Contact]] ()
    var filteredText = ""
    
    
    fileprivate var unformattedContacts = [Contact] ()
    
    fileprivate var datasource = [ContactListDatastructure] ()
    fileprivate weak var delegate : ViewModelDelegate?
    
    init (delegate : ViewModelDelegate) {
        self.delegate = delegate
    }
    
    // Methods to Initilize Contacts Array
    func inililizeFetch () {
        
//        DispatchQueue.main.async {
//            if let request = Contact.sortedFetchRequest {
//                let predicate = NSPredicate(format: "isContact == %@", NSNumber.init(value: true))
//                request.predicate = predicate
//                request.shouldRefreshRefetchedObjects = true
//                request.returnsObjectsAsFaults = false
//
//                let context = AppDelegate.viewContext
//                do {
//                    let result = try context.fetch(request)
//                    self.datasource.removeAll()
//                    self.unformattedContacts = result
//                    self.filterContacts()
//                }
//                catch {
//                    self.informCompletionForError ()
//                }
//            }
//        }
    }
    
    
    private func sort (withData data : [Contact]) {
        
        var contacts = [Character: [Contact]]()
        
//        for entry in data {
//
//            let name = entry.displayName!.capitalizingFirstLetter()
//            if contacts[name[entry.displayName!.startIndex]] == nil {
//                contacts[name[entry.displayName!.startIndex]] = [Contact]()
//            }
//            contacts[name[name.startIndex]]!.append(entry)
//        }
        
        self.contacts = contacts
        
        self.informCompletion()
    }
    
    private func informCompletion () {
        DispatchQueue.main.async () {
            self.datasource.removeAll()
            for (letter, list) in self.contacts.reversed() {
                let dataSource = ContactListDatastructure.init(withInitials: String(letter), contacts: list)
                self.datasource.append(dataSource)
            }
            
            self.datasource.sort(by: { (first, second) -> Bool in
                return first.initials < second.initials
            })
            self.delegate?.reload()
        }
    }
    
    private func informCompletionForError () {
        DispatchQueue.main.async () {
            self.delegate?.didReceiveError(withMessage:NSLocalizedString("unknownError", comment: "Some error") )
        }
    }
    
    
    // Methods to Access Contacts
    func numberOfSection () -> Int {
        return 1 //datasource.count
    }
    
    func numberOfRows (inSectionIndex index : Int) -> Int {
        return 3 // datasource[index].contacts.count
    }
    
    func contactAtIndex (atIndex section : Int, row : Int) -> Contact {
        return datasource [section].contacts[row]
    }
    
    func titleOfSection (atIndex index : Int) -> String {
        return  "A"//datasource [index].initials
    }
    
    func allTitlesForSection () -> [String] {
        var sections = [String] ()
        
        for item in datasource {
            sections.append(item.initials)
        }
        sections.append ("A")
        return sections
    }
//
//    func nameForContact (atSectionIndex section : Int, row : Int) -> String {
//        return "name"
//        if let name = datasource[section].contacts [row].displayName {
//            return name
//        }
//        else {
//            return "No Name at section \(section) row \(row) ID \(datasource[section].contacts [row].contactID)"
//        }
//    }
//
//    func imageTagForContact (atSectionIndex section : Int, row : Int) -> String? {
//        return datasource[section].contacts[row].imageTag
//    }
//
//    func imageForContact (atSectionIndex section : Int, row : Int) -> UIImage {
//        if let imageData = datasource[section].contacts[row].thumnailImage {
//            if let image = UIImage.init(data: imageData) {
//                return image
//            }
//            else {
//                return UIImage.init(named: "user")!
//            }
//        }
//        else {
//            return UIImage.init(named: "user")!
//        }
//    }
//
//    func statusForContact (atSectionIndex section : Int, row : Int) -> String {
//        if let statusMessage = datasource[section].contacts[row].statusMessage {
//            return statusMessage
//        }else{
//            return ""
//        }
//    }
    
    func isContactBlocked (atSectionIndex section : Int, row : Int) -> Bool {
        return datasource[section].contacts[row].isBlocked
    }
    
    func getContactForItem (atSectionIndex section : Int, row : Int) -> Contact {
        return datasource[section].contacts[row]
    }
    
    func filted (withText text : String) {
        self.filteredText = text
        filterContacts()
    }
    
    func filterContacts() {
        if self.filteredText.isBlank {
            self.sort(withData: self.unformattedContacts)
        }
        else {
            let filterResult = self.unformattedContacts.filter { (contact) -> Bool in
                
//                let phoneNumber = contact.phoneNumber.lowercased()
//                let displayName = contact.displayName.lowercased()
                let searchText = self.filteredText.lowercased()
                
//                if phoneNumber.contains(searchText) || displayName.contains(searchText) {
//                    return true
//                }
//                else {
//                    return false
//                }
                return false
                
            }
            self.sort(withData: filterResult)
        }
    }
    
}
