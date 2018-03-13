//
//  PrivacyViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    var photoPrivacyLevel : PrivacyLevel = .contacts
    var statusPrivacyLevel : PrivacyLevel = .contacts
    var blockedCount = 0
    
    enum CellType {
        case photo
        case status
        case blocked
        
        var label : String? {
            switch self {
            case .photo:
                return "Profie Photo"
            case .status:
                return "Status"
            case .blocked:
                return "Blocked"
            }
        }
    }
    
    fileprivate var datasource = [[CellType]] ()
    
    fileprivate func constructDatasource () {
        var sectionOne = [CellType] ()
        sectionOne.append(.photo)
        sectionOne.append(.status)
        
        var sectionTwo = [CellType] ()
        sectionTwo.append(.blocked)
        
        datasource.append(sectionOne)
        datasource.append(sectionTwo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Privacy"
        self.navigationItem.largeTitleDisplayMode = .never
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        photoPrivacyLevel = PrivacyLevel(rawValue: UserDefaults.standard.integer(forKey: "profile_photo"))!
        statusPrivacyLevel = PrivacyLevel(rawValue: UserDefaults.standard.integer(forKey: "status"))!
        blockedCount = 0 //ContactHelper.getBlockedUsersCount()
        
        datasource.removeAll()
        constructDatasource()
        
        self.tableView.reloadData()
    }
}

extension PrivacyViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = datasource[section]
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "privacyCell", for: indexPath)
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .photo:
            currentCell.detailTextLabel?.text = photoPrivacyLevel.title
            break
        case .status:
            currentCell.detailTextLabel?.text = statusPrivacyLevel.title
            break
        case .blocked:
            if blockedCount == 0 {
                currentCell.detailTextLabel?.text = "None"
            }else if blockedCount == 1 {
                currentCell.detailTextLabel?.text = "\(blockedCount) contact"
            }else{
                currentCell.detailTextLabel?.text = "\(blockedCount) contacts"
            }
            break
        }
        currentCell.textLabel?.text = type.label
        currentCell.detailTextLabel?.textColor = UIColor.lightGray
        currentCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return currentCell
    }
    
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let item = datasource[section]
        if item.contains(.blocked){
            return "List of contacts you have blocked."
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .photo:
            let selectPrivacyViewController = UIStoryboard.settingsStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.SelectPrivacyController.rawValue) as! SelectPrivacyViewController
            selectPrivacyViewController.navigationType = .photo
            selectPrivacyViewController.selectedPrivacyLevel = photoPrivacyLevel
            self.navigationController?.pushViewController(selectPrivacyViewController, animated: true)
            break
        case .status:
            let selectPrivacyViewController = UIStoryboard.settingsStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.SelectPrivacyController.rawValue) as! SelectPrivacyViewController
            selectPrivacyViewController.navigationType = .status
            selectPrivacyViewController.selectedPrivacyLevel = statusPrivacyLevel
            self.navigationController?.pushViewController(selectPrivacyViewController, animated: true)
            break
        case .blocked:
//            let blockedVC = UIStoryboard.settingStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.blockedController.rawValue)
//            self.navigationController?.pushViewController(blockedVC, animated: true)
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
