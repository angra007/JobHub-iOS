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



class JobsViewModel {
    
    
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

    private func getAllJobs ()  {
        let context = AppDelegate.viewContext
        if let request = Job.sortedFetchRequest {
            do {
                jobs = try context.fetch(request)
            }
            catch {
            }
        }
    }
    
    
    func loadAll (completion : @escaping WebRequestCompletionHandler) {
        NetworkManager.getValueForSingleEvent(forReference: RequestType.job.reference) { [unowned self] (response) in
            if let snapShot = response as? DataSnapshot {
                let context = AppDelegate.viewContext
                if let result = snapShot.value as? [Any] {
                     _ = result.map() {
                        if let dict = $0 as? [String : Any] {
                            context.performChanges {
                                let job = Job.insert(into: context, withData: dict)
                                self.jobs.append(job)
                            }
                        }
                    }
                }
                completion (nil)
            }
        }
    }
}
