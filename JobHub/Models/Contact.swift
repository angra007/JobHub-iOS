//
//  People.swift
//  JobHub
//
//  Created by Ankit Angra on 14/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation
import CoreData

class Contact : NSManagedObject {
    @NSManaged fileprivate(set) var firstName : String?
    @NSManaged fileprivate(set) var industry : String?
    @NSManaged fileprivate(set) var interestLocation : [String]?
    @NSManaged fileprivate(set) var intrestedIndusties : [String]?
    @NSManaged fileprivate(set) var isBlocked : Bool
    @NSManaged fileprivate(set) var location : String?
    @NSManaged fileprivate(set) var organisation : String?
    @NSManaged fileprivate(set) var selectedTitles : [String]?
    @NSManaged fileprivate(set) var skills : String?
    @NSManaged fileprivate(set) var workExperience : String?
}



