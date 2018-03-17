//
//  People.swift
//  JobHub
//
//  Created by Ankit Angra on 14/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import Foundation

enum PeopleType {
    case none
    case Suggestion
    case Requests
    case Blocked
}


struct PeopleTableViewDatasource {
    var type : PeopleType = .none
    var people : [People]
}


class People {
    
    var id : String?
    var name : String?
    var email : String?
    var firstName : String?
    var lastName : String?
    var location : String?
    var organisation : String?
    
    init(withJson json : [String : AnyObject]) {
        self.name = json ["name"] as? String
        self.email = json ["email"] as? String
        self.firstName = json ["firstName"] as? String
        self.lastName = json ["lastName"] as? String
        self.location = json ["location"] as? String
        self.organisation = json ["organisation"] as? String
        self.id = json ["id"] as? String
    }
}
