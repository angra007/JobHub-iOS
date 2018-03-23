//
//  PeopleViewModel.swift
//  JobHub
//
//  Created by Ankit Angra on 16/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation
import Firebase

protocol  PeopleViewModelDelegate : class {
    func showActivityIndicator ()
    func hideActivityIndicator ()
    func reloadTableView (withDatasource datasource : [PeopleTableViewDatasource])
}

class PeopleViewModel {
    weak var delegate : PeopleViewModelDelegate!
    
    
    var tableViewDatasource = [PeopleTableViewDatasource] ()
    
    
    struct Datasource {
        var type : PeopleType = .none
        var people : People
    }
    
    
    func getSuggestions (withCompletion completion : @escaping (Bool) -> ()) {
        var datasource = [Datasource] ()
        NetworkManager.getValueForSingleEvent(forReference: RequestType.users.reference) { [unowned self] (response) in
            if let snapShot = response as? DataSnapshot {
                if let dict = snapShot.value as? [String : AnyObject] {
                    let allKeys = Array(dict.keys)
                    var count = 0
                    _ = allKeys.map() {
                        if var value = dict [$0] as? [String : AnyObject] {
                            
                            if $0 != Auth.auth().currentUser!.uid {
                                value ["id"] = $0 as AnyObject
                                let reference = RequestType.people.reference.child($0)
                                NetworkManager.getValueForSingleEvent(forReference: reference, completion: { (response) in
                                    count = count + 1
                                    if let data = response as? DataSnapshot {
                                        if let dict = data.value as? [String : AnyObject] {
                                            if dict ["status"] as! String == "suggestion" {
                                                let people = People.init(withJson: value)
                                                let peopleData = Datasource.init(type: .Suggestion, people: people)
                                                datasource.append(peopleData)
                                            }
                                        }
                                        else {
                                            let data = ["status" : "suggestion"]
                                            NetworkManager.updateInformation(forReference: reference, values: data as [String : AnyObject], completion: { (response) in
                                                let people = People.init(withJson: value)
                                                let peopleData = Datasource.init(type: .Suggestion, people: people)
                                                datasource.append(peopleData)
                                            })
                                        }
                                    }
                                    
                                    if let item = datasource.last {
                                        let type = item.type
                                        let people = item.people
                                        
                                        if type == .Suggestion {
                                            var suggestionType = self.tableViewDatasource [1]
                                            var peoples = suggestionType.people
                                            peoples.append(people)
                                            suggestionType.people = peoples
                                            self.tableViewDatasource [1] = suggestionType
                                        }
                                    }
                                    
                                    
                                    if count == allKeys.count - 1 {
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
    
    func getRequests (withCompletion completion : @escaping (Bool) -> ()) {
        
        var datasource = [Datasource] ()
        let reference = RequestType.users.reference.child(Auth.auth().currentUser!.uid).child("requests")
        NetworkManager.getValueForSingleEvent(forReference: reference) { (response) in
            if let snapShot = response as? DataSnapshot {
                
                var count = 0
                if let value = snapShot.value as? [String] {
                    _ = value.map() {
                        let userID = $0
                        
                        let reference = RequestType.users.reference.child(userID)
                        NetworkManager.getValueForSingleEvent(forReference: reference, completion: { (response) in
                                count = count + 1
                                if let data = response as? DataSnapshot {
                                    if var value = data.value as? [String : AnyObject] {
                                        value ["id"] = userID as AnyObject
                                        let people = People.init(withJson: value)
                                        let peopleData = Datasource.init(type: .Requests, people: people)
                                        datasource.append(peopleData)
                                    }
                                }
                            
                                if let item = datasource.last {
                                    let type = item.type
                                    let people = item.people
                                
                                    if type == .Requests {
                                        var suggestionType = self.tableViewDatasource [0]
                                        var peoples = suggestionType.people
                                        peoples.append(people)
                                        suggestionType.people = peoples
                                        self.tableViewDatasource [0] = suggestionType
                                    }
                                }
                            
                            if count == value.count {
                                completion (true)
                            }
   
                        })
                    }
                }
                else {
                    completion (true)
                }
            }
        }
        
        
    }
    
    func getAllPeople () {
        tableViewDatasource.removeAll()
        let suggestionDatasource = PeopleTableViewDatasource.init(type: .Suggestion, people: [])
        let requestDatasource = PeopleTableViewDatasource.init(type: .Requests, people: [])
        //let blockedDatasource = PeopleTableViewDatasource.init(type: .Blocked, people: [])
        
        tableViewDatasource.append(requestDatasource)
        tableViewDatasource.append(suggestionDatasource)
        self.delegate.showActivityIndicator()
        
        
        
        self.getSuggestions { (finished) in
            self.getRequests(withCompletion: { (done) in
                self.delegate.hideActivityIndicator()
                self.delegate.reloadTableView(withDatasource: self.tableViewDatasource)
            })
        }
        
    }
    
    
    func changeStatus (currentStatus : PeopleType, id : String) {
        let reference = RequestType.people.reference.child(id)
        let status = currentStatus.status
        let data = ["status" : status]
        NetworkManager.updateInformation(forReference: reference, values: data as [String : AnyObject]) { (response) in
            
        }
    }
    
    func acceptRequest (forUserID id : String, completion : @escaping (Bool) -> ()) {
        let reference = RequestType.contacts.reference
        
        var friends = [String] ()
        NetworkManager.getValueForSingleEvent(forReference: reference) { (response) in
            if let snapshot = response as? DataSnapshot {
                if let data = snapshot.value as? [String : AnyObject] {
                    friends = data ["accepted"] as! [String]
                 }
                friends.append(id)
                
                let values = ["accepted" : friends]
                NetworkManager.updateInformation(forReference: reference, values: values as [String : AnyObject], completion: { (response) in
                    self.removeUserFromRequest(withUserID: id, completion: { (finsihed) in
                        //self.delegate.hideActivityIndicator()
                        completion (true)
                    })
                })
            }
        }
    }
    
    func removeUserFromRequest (withUserID userID : String, completion : @escaping (Bool) -> ()) {
        let reference = RequestType.users.reference.child(Auth.auth().currentUser!.uid).child("requests")
        
        var requests = [String] ()
        NetworkManager.getValueForSingleEvent(forReference: reference, completion: { (response) in
            if let snapshot = response as? DataSnapshot {
                
                if let value = snapshot.value as? [String] {
                    requests = value
                }
                requests.remove(at: requests.index(of: userID)!)
                let id = Auth.auth().currentUser!.uid
                
                let dict = ["requests" : requests]
                NetworkManager.updateInformation(forReference: RequestType.users.reference.child(id), values: dict as [String : AnyObject], completion: { (response) in
                    completion (true)
                })
            }
        })
    }
    
    func rejectRequest (forUserID id : String, completion : @escaping (Bool) -> ()) {
        self.delegate.showActivityIndicator()
        self.removeUserFromRequest(withUserID: id, completion: { (finsihed) in
            self.delegate.hideActivityIndicator()
            completion (true)
        })
    }
 }
