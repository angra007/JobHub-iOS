//
//  JobHelper.swift
//  JobHub
//
//  Created by Ankit Angra on 14/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation
import CoreData
import Firebase

protocol JobsViewModelDelegate : class {
    func fetchCompleted ()
}

class JobsViewModel {
    
    weak var delegate : JobsViewModelDelegate!
    var jobs = [Job] ()
    
    
    func getJobCount () -> Int {
        if jobs.count == 0 {
            getAllJobs ()
        }
        return jobs.count
    }
    
    func getJob (atIndex index : Int) -> Job {
        return jobs [index]
    }
    
    func getAllJobs ()  {
        let context = AppDelegate.viewContext
        if let request = Job.sortedFetchRequest {
            do {
                jobs = try context.fetch(request)
            }
            catch {
            }
        }
    }
    
    func loadAll () {

        jobs.removeAll()
        var jobIndustries = [String] ()
        let userReference = RequestType.profile.reference.child("intrestedIndusties")
        NetworkManager.getValueForSingleEvent(forReference: userReference) { [unowned self] (response) in
            if let snapShot = response as? DataSnapshot {
                if let value = snapShot.value as? [String] {
                    jobIndustries = value
                    print(jobIndustries)
                    
                    var items = [String] ()
                    items = jobIndustries.map() {
                        return self.getKey(forIndustry: $0)
                    }
                    
                    for (n, c) in items.enumerated() {                        
                        let industryReference = RequestType.job.reference.child(c)
                        NetworkManager.getValueForSingleEvent(forReference: industryReference) { (response) in
                            if let snapShot = response as? DataSnapshot {
                                if let value = snapShot.value as? [[String : Any]] {
                                    _ = value.map() {
                                        let data = $0
                                        let context = AppDelegate.viewContext
//                                        context.performChanges {
//
//                                        }
                                        let job = Job.insert(into: context, withData: data)
                                        self.jobs.append(job)
                                    }
                                }
                            }
                            if items.last == c {
                                self.delegate.fetchCompleted()
                            }
                        }
                        ()
                    }
                }
            }
        }
        
    }
    
    //"Accounting and Finance", "Administrative and Clerical", "Media and Entertainment", "Customer Service"
    func getKey (forIndustry industry : String) -> String {
        if industry == "Accounting and Finance" {
            return "Accounts"
        }
        else if industry == "Administrative and Clerical" {
            return "Administrative"
        }
        else if industry == "Media and Entertainment" {
            return "Arts"
        }
        else if industry == "Customer Service" {
            return "customerService"
        }
        else {
            return "Accounts"
        }
    }
    
    
}
