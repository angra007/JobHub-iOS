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
        var newItems = false;
        NetworkManager.child(forReference: RequestType.job.reference) { [unowned self] (response) in
            if let snapShot = response as? DataSnapshot {
                if newItems == false {
                    return
                }
                let context = AppDelegate.viewContext
                if let result = snapShot.value as? [String : Any] {
                    context.performChanges {
                        let job = Job.insert(into: context, withData: result)
                        self.jobs.append(job)
                    }
                }
            }
        }
        
        NetworkManager.getValueForSingleEvent(forReference: RequestType.job.reference) { (response) in
            newItems = true
            self.delegate.fetchCompleted()
        }
    }
}
