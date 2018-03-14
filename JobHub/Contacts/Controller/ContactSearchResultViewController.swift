//
//  ContactListViewController.swift
//  Radar Locator
//
//  Created by Ankit Angra on 16/11/17.
//  Copyright © 2017 Radar Labs Pvt Ltd. All rights reserved.
//

import UIKit
import CoreData

protocol ContactSearchResultDelegate : class {
    func tableViewDidSet ()
}

class ContactSearchResultViewController: UIViewController {
    weak var delegate : ContactSearchResultDelegate!    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(ContactListTableViewCell.self)
            self.delegate.tableViewDidSet()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
    }
}


