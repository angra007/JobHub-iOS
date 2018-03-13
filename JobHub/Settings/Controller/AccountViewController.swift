//
//  AccountViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    enum CellType {
        
        case privacy
        case changeNumber
        case deleteAccount
        
        var label : String? {
            switch self {
            case .privacy:
                return "Privacy"
            case .changeNumber:
                return "Change Number"
            case .deleteAccount:
                return "Delete My Account"
            }
        }
    }
    
    fileprivate var datasource = [[CellType]] ()
    
    fileprivate func constructDatasource () {
        var section = [CellType] ()
        section.append(.privacy)
        section.append(.changeNumber)
        section.append(.deleteAccount)
        datasource.append(section)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Account"
        self.navigationItem.largeTitleDisplayMode = .never
        tableView.delegate = self
        tableView.dataSource = self
        constructDatasource ()
        
    }
}

extension AccountViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        let currentCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath)
        currentCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        currentCell.textLabel?.text = type.label
        return currentCell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .privacy:
            let privacyViewController = UIStoryboard.settingsStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.PrivacyController.rawValue) as! PrivacyViewController
            self.navigationController?.pushViewController(privacyViewController, animated: true)
            break
        case .changeNumber:
            let changeNumberController = UIStoryboard.settingsStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.ChangePhoneNumberController.rawValue)
            self.navigationController?.pushViewController(changeNumberController, animated: true)
            break
        case .deleteAccount:
            let deleteAccountController = UIStoryboard.settingsStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.DeleteAccountController.rawValue) as! DeleteAccountViewController
            self.navigationController?.pushViewController(deleteAccountController, animated: true)
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

