//
//  ContactProfileViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class ContactProfileViewController: UIViewController {

    
    var contact : Contact!
    var profileImage : UIImage!
    var isLandscape = false
    weak var imageCenterYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ContactProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        
        return cell
    }
}
