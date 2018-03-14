//
//  ChatListingViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 12/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class ChatListingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ChatListingTableViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Chats"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ChatListingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ChatListingTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.profileImage.image = UIImage(named : "user")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}


