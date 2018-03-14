//
//  CoreDataHelper.swift
//  Radar Locator
//
//  Created by Ankit Angra on 17/11/17.
//  Copyright © 2017 Radar Labs Pvt Ltd. All rights reserved.
//

import CoreData

protocol Managed: class, NSFetchRequestResult {
    static var entityName: String? { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}


extension Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    static var sortedFetchRequest: NSFetchRequest<Self>? {
        let request = NSFetchRequest<Self>(entityName: String (describing: self))
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}

extension Managed where Self: NSManagedObject {
    static func findOrCreate(in context: NSManagedObjectContext, matching predicate: NSPredicate, configure: (Self) -> ()) -> Self {
        
        if let obj = getEntity(predicate: predicate, context: context) {
            configure(obj)
            return obj
        }
        else {
            let newObject: Self = context.insertObject()
            configure(newObject)
            return newObject
        }
        
    }
    
    
    
    static func getEntity(predicate: NSPredicate, context : NSManagedObjectContext) -> Self? {
        
        if let request = Self.sortedFetchRequest {
            do {
                request.predicate = predicate
                let result = try context.fetch(request)
                
                if result.count > 0 {
                    return result.first
                }
            }
            catch {
            }
            return nil
        }
        else {
            return nil
        }
    }
    
    
    
    static func findOrFetch(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        guard let object = materializedObject(in: context, matching: predicate) else {
            return fetch(in: context) { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
                }.first
        }
        return object
    }
    
    static func materializedObject(in context: NSManagedObjectContext, matching predicate: NSPredicate) -> Self? {
        context.reset()
        for object in context.registeredObjects where !object.isFault {
            guard let result = object as? Self, predicate.evaluate(with: result) else { continue }
            return result
        }
        
        return nil
    }
    
    static func fetch(in context: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> () = { _ in }) -> [Self] {
        let request = NSFetchRequest<Self>(entityName: Self.entityName!)
        configurationBlock(request)
        return try! context.fetch(request)
    }
    
    static var entityName: String? {
        if let name = entity().name {
            return name
        }
        else {
            return nil
        }
    }
}


extension NSManagedObjectContext {
    func insertObject<A: NSManagedObject>() -> A where A: Managed {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entityName!, into: self) as? A else { fatalError("Wrong object type") }
        return obj
    }
    
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    func performChanges(block: @escaping () -> ()) {
        perform {
            block()
            _ = self.saveOrRollback()
        }
    }
    
    func performBulkInsertChanges (block: @escaping () -> ()) {
        perform {
            block()
        }
    }
    
    func performFetch(block: @escaping () -> ()) {
        perform {
            block()
            _ = self.saveOrRollback()
        }
    }
}



