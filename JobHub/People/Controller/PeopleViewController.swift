//
//  PeopleViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 14/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    var searchController : UISearchController!
    var searchResultController : PeopleSearchResultViewController!
    
    
    fileprivate func setUpSearchBar() {
        
        self.searchResultController = UIStoryboard.peopleStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.PeopleSearchResultController.rawValue) as! PeopleSearchResultViewController
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
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(PeopleListingTableViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpSearchBar()
        
        self.navigationItem.title = "People"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        
        // Do any additional setup after loading the view.
    }
}

extension PeopleViewController : PeopleSearchResultDelegate {
    func tableViewDidSet () {
        
    }
}

extension PeopleViewController :  UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension PeopleViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PeopleListingTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

extension PeopleViewController : PeopleListingDelegate {
    func didTapConfirm(atIndex index: Int) {
        
    }
    
    func didTapReject(atIndex index: Int) {
        
    }
}
