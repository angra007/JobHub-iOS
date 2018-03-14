//
//  Statuses.swift
//  Radar Locator
//
//  Created by Ankit Angra on 14/11/17.
//  Copyright © 2017 Radar Labs Pvt Ltd. All rights reserved.
//

import UIKit
import CoreData

//class Status: NSManagedObject {
//    @NSManaged fileprivate(set) var status : String!
//    @NSManaged fileprivate(set) var addedTime : Int64
//
//    static func insert (into context: NSManagedObjectContext, withData data : [String : Any]) -> Status {
//        let statuses : Status = context.insertObject ()
//        statuses.status = data ["status"] as! String
//        statuses.addedTime = data ["addedTime"] as! Int64
//        return statuses
//    }
//
//    static func addOrUpdateStatus (inContext context : NSManagedObjectContext ,withText text : String) {
//        if let allStatus = StatusesHelper.getAllStatus() {
//            let satuses = allStatus.filter({ (currentStatus) -> Bool in
//                if currentStatus.status == text {
//                    return true
//                }
//                else {
//                    return false
//                }
//            })
//
//            if satuses.count > 0 {
//                update(inContext: context, status: satuses.first!)
//            }
//            else {
//                addStatus(text, inContext: context)
//            }
//        }
//    }
//
//    static func update (inContext context : NSManagedObjectContext ,status : Status) {
//        let date = Date.init()
//        let timeStamp = Int (date.timeIntervalSince1970 * 1000)
//        status.addedTime = Int64(timeStamp)
//        _ = context.saveOrRollback()
//    }
//
//    static func addStatus ( _ status : String, inContext context : NSManagedObjectContext ) {
//
//        let date = Date.init()
//        let timeStamp = Int (date.timeIntervalSince1970 * 1000)
//
//        let statuses : Status = context.insertObject ()
//        statuses.status = status
//        statuses.addedTime = Int64(timeStamp)
//        _ = context.saveOrRollback()
//    }
//
//}

//extension Status: Managed {
//    static var defaultSortDescriptors: [NSSortDescriptor] {
//        return [NSSortDescriptor(key: #keyPath(addedTime), ascending: false)]
//    }
//}

