//
//  PeopleSearchResultViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 14/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit


protocol  PeopleSearchResultDelegate : class {
    func tableViewDidSet ()
}

class PeopleSearchResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.delegate.tableViewDidSet()
        }
    }
    
    weak var delegate : PeopleSearchResultDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
