//
//  JobSearchViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 09/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class JobSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(JobListCellTableViewCell.self)
        }
    }
    
    var searchController : UISearchController!
    var searchResultController : JobSearchListingViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Available Jobs"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        
        setUpSearchBar()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    fileprivate func setUpSearchBar() {
        
        self.searchResultController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobSearchListingController.rawValue) as! JobSearchListingViewController
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

}

extension JobSearchViewController : UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        //contactViewModel.filted(withText: searchController.searchBar.text! )
    }
}


extension JobSearchViewController : JobSearchResultDelegate {
    func tableViewDidSet () {
        
    }
}

extension JobSearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobListCellTableViewCell", for: indexPath)
            
            
        return cell
    }
    
    
    
    
}


