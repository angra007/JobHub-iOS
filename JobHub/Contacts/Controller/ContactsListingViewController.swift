//
//  ContactsListingViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 12/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

protocol ContactListDelegate : class {
    func didSelectContact ( )
}


class ContactsListingViewController: UIViewController {

    var searchController : UISearchController!
    var searchResultController : ContactSearchResultViewController!
    weak var delegate : ContactListDelegate!
    var navigationType : ContactNavigationType = .none
    var contactViewModel : ContactsViewModel!
    
    fileprivate var currentIndexPath : IndexPath!
    fileprivate var dismissedController = false
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ContactListTableViewCell.self)
            tableView.register(AddContactTableViewCell.self)
        }
    }
    
    fileprivate func setUpSearchBar() {
        
        self.searchResultController = UIStoryboard.contactsStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.ContactsSearchResultController.rawValue) as! ContactSearchResultViewController
        self.searchResultController.delegate = self
        
        self.searchController = UISearchController(searchResultsController:  self.searchResultController)
        
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = true
        self.searchController.dimsBackgroundDuringPresentation = true
        
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
        } else {
            self.navigationItem.titleView = searchController.searchBar
        }
        self.definesPresentationContext = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Contacts"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        
        setUpSearchBar()
        
        contactViewModel = ContactsViewModel.init(delegate: self)
        
        if navigationType == .block {
            let doneButton = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector (didTapCancelButton))
            self.navigationItem.rightBarButtonItem = doneButton
        }
        
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension ContactsListingViewController : ViewModelDelegate {
    func reload () {
        if self.tableView != nil {
            self.tableView.reloadData()
            if self.searchResultController.tableView != nil {
                self.searchResultController.tableView.reloadData()
            }
        }
    }
    
    func didReceiveError (withMessage message : String) {
        
    }
}

extension ContactsListingViewController : ContactSearchResultDelegate {
    func tableViewDidSet() {
        self.searchResultController.tableView.delegate = self
        self.searchResultController.tableView.dataSource = self
    }
}


extension ContactsListingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactViewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactViewModel.numberOfRows(inSectionIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ContactListTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.profileImageView.image = UIImage(named : "user")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(named : "darkerGrey")
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 4, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont.systemFont(ofSize: 17)
        headerLabel.textColor = UIColor.darkGray
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactViewModel.titleOfSection(atIndex: section)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactViewModel.allTitlesForSection()
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        let allTitles = contactViewModel.allTitlesForSection()
        return allTitles.index(of: title)!
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let contact = contactViewModel.getContactForItem(atSectionIndex: indexPath.section, row: indexPath.row)
//        let image = (tableView.cellForRow(at: indexPath) as! ContactListTableViewCell).profileImageView.image
//        if navigationType == .block {
//
//        } else {
//            self.delegate.didSelectContact()
//        }
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
    }
}

extension ContactsListingViewController : UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

