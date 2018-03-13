//
//  DeleteAccountViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class DeleteAccountViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(DeleteInfoTableViewCell.self)
            tableView.register(PhoneNumberTableViewCell.self)
        }
    }
    
    
    enum CellType {
        
        case info
        case number
        case action
        
    }
    
    fileprivate var datasource = [[CellType]] ()
    
    fileprivate func constructDatasource () {
        var sectionOne = [CellType] ()
        sectionOne.append(.info)
        datasource.append(sectionOne)
        
        var sectionTwo = [CellType] ()
        sectionTwo.append(.number)
        datasource.append(sectionTwo)
        
        var sectionThree = [CellType] ()
        sectionThree.append(.action)
        datasource.append(sectionThree)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Delete My Account"
        self.navigationItem.largeTitleDisplayMode = .never
        tableView.delegate = self
        tableView.dataSource = self
        constructDatasource ()
        
        // Do any additional setup after loading the view.
    }

}

extension DeleteAccountViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let item = datasource[section]
        if item.contains(.number) {
            return "ENTER YOUR PHONE NUMBER:"
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .action:
            return indexPath
        default :
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .action:
            
             return true
        default :
            return false
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .info:
            let currentCell : DeleteInfoTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
            return currentCell
        case .number:
            let currentCell : PhoneNumberTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
            
            return currentCell
        case .action:
            let currentCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "deleteCell", for: indexPath)
            currentCell.textLabel?.text = "Delete My Account"
            currentCell.textLabel?.textAlignment = .center
            currentCell.textLabel?.textColor = UIColor.red
            return currentCell
        }
    }
    
}

