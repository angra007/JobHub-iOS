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
    func reloadTableView (withDatasource datasource : [PeopleTableViewDatasource])
}

class PeopleViewModel {
    weak var delegate : PeopleViewModelDelegate!
    
    
    var tableViewDatasource = [PeopleTableViewDatasource] ()
    
    
    struct Datasource {
        var type : PeopleType = .none
        var people : People
    }
    
    
    func getAllPeople () {
        tableViewDatasource.removeAll()
        
        let suggestionDatasource = PeopleTableViewDatasource.init(type: .Suggestion, people: [])
        let requestDatasource = PeopleTableViewDatasource.init(type: .Requests, people: [])
        //let blockedDatasource = PeopleTableViewDatasource.init(type: .Blocked, people: [])
        
        tableViewDatasource.append(suggestionDatasource)
        tableViewDatasource.append(requestDatasource)
        
        var datasource = [Datasource] ()
        NetworkManager.getValueForSingleEvent(forReference: RequestType.users.reference) { [unowned self] (response) in
            if let snapShot = response as? DataSnapshot {
                if let dict = snapShot.value as? [String : AnyObject] {
                    let allKeys = Array(dict.keys)
                    _ = allKeys.map() {
                        if var value = dict [$0] as? [String : AnyObject] {
                            
                            if $0 != Auth.auth().currentUser!.uid {
                                value ["id"] = $0 as AnyObject
                                let reference = RequestType.people.reference.child($0)
                                NetworkManager.getAllValues(forReference: reference, completion: { (response) in
                                    
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
                                    
                                    let item = datasource.last!
                                    let type = item.type
                                    let people = item.people
                                    
                                    if type == .Suggestion {
                                        var suggestionType = self.tableViewDatasource [0]
                                        var peoples = suggestionType.people
                                        peoples.append(people)
                                        suggestionType.people = peoples
                                        self.tableViewDatasource [0] = suggestionType
                                    }
                                    else {
                                        var suggestionType = self.tableViewDatasource [1]
                                        suggestionType.people.append(people)
                                    }
                                    self.delegate.reloadTableView(withDatasource: self.tableViewDatasource)

                                })
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
}
