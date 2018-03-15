//
//  Jobs.swift
//  JobHub
//
//  Created by Ankit Angra on 14/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation
import CoreData

class Job : NSManagedObject {
    
    @NSManaged fileprivate(set) var city : String?
    @NSManaged fileprivate(set) var company : String?
    @NSManaged fileprivate(set) var country : String?
    @NSManaged fileprivate(set) var email : String?
    @NSManaged fileprivate(set) var id : String?
    @NSManaged fileprivate(set) var jobTitle : String?
    @NSManaged fileprivate(set) var phoneNumber : String?
    @NSManaged fileprivate(set) var requiredExperience : Double
    @NSManaged fileprivate(set) var salary : String?
    @NSManaged fileprivate(set) var createdAt : Date?
    @NSManaged fileprivate(set) var jobSatisfaction : Double
    @NSManaged fileprivate(set) var industry : String?
    
    static func insert(into context: NSManagedObjectContext, withData data : [String : Any]) -> Job {
        
        let id = data ["_id"] as? String
        let predicate = NSPredicate(format: "id CONTAINS[C] %@",id!)
        
        return Job.findOrCreate(in: context, matching: predicate, configure: { (jobs) in
            jobs.city = data ["city"] as? String
            jobs.company = data ["Company"] as? String
            jobs.country = data ["Country"] as? String
            jobs.email = data ["Contact"] as? String
            jobs.id = data ["_id"] as? String
            jobs.jobTitle = data ["Title"] as? String
            jobs.phoneNumber = data ["phone"] as? String
            jobs.requiredExperience = (data ["Experience"] as? Double)!
            jobs.salary = data ["Salary"] as? String
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: data ["Created"] as! String)!
            
            jobs.createdAt = date
            jobs.industry = data ["Industy"] as? String
        })
        
    }
}

extension Job: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(createdAt), ascending: false)]
    }
}
