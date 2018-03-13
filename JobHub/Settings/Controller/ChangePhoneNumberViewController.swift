//
//  ChangePhoneNumberViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class ChangePhoneNumberViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(PhoneNumberTableViewCell.self)
        }
    }
    enum CellType {
        case oldNumber
        case newNumber
        
        var headerTitle : String {
            switch self {
            case .oldNumber:
                return "Your old country code and phone number"
            case .newNumber:
                return "Your new country code and phone number"
            }
        }
    }
    
    fileprivate var datasource = [[CellType]] ()
    
    fileprivate func constructDatasource () {
        var sectionOne = [CellType] ()
        sectionOne.append(.oldNumber)
        datasource.append(sectionOne)
        
        var sectionTwo = [CellType] ()
        sectionTwo.append(.newNumber)
        datasource.append(sectionTwo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Change Number"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        constructDatasource ()
        
        let nextButton = UIBarButtonItem.init(title: "Next", style: .done, target: self, action: #selector (didTapNextButton))
        self.navigationItem.rightBarButtonItem = nextButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func didTapNextButton() {
        
    }
}

extension ChangePhoneNumberViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let item = datasource[section]
        let type = item[0]
        return type.headerTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .oldNumber:
            let currentCell : PhoneNumberTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
            return currentCell
        case .newNumber:
            let currentCell : PhoneNumberTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
            return currentCell
        }
    }
}
