//
//  PeopleViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 14/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit
import Firebase

class PeopleViewController: UIViewController {

    var searchController : UISearchController!
    var searchResultController : PeopleSearchResultViewController!
    var peopleViewModel : PeopleViewModel!
    
    private var datasource = [PeopleTableViewDatasource] ()
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
        
        peopleViewModel = PeopleViewModel ()
        peopleViewModel.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 0)
        peopleViewModel.getAllPeople ()
        // Do any additional setup after loading the view.
    }
}

extension PeopleViewController : PeopleViewModelDelegate {
    func reloadTableView(withDatasource datasource: [PeopleTableViewDatasource]) {
        self.datasource = datasource
        self.tableView.reloadData()
    }
    
    func showActivityIndicator () {
        ActivityIndicatorManager.showActivityIndicator()
    }
    
    func hideActivityIndicator () {
        ActivityIndicatorManager.dismissActivityIndicator()
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
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource [section].people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PeopleListingTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
        cell.delegate = self
        cell.currentIndex = indexPath
        let people = self.datasource [indexPath.section].people [indexPath.row]
        
        cell.nameLabel.text = people.firstName! + " " + people.lastName!

        if people.organisation == nil && people.location != nil {
            cell.jobTitleLabel.text = people.location
        }
        else if people.organisation != nil && people.location != nil {
            cell.jobTitleLabel.text = people.organisation! + " at " + people.location!
        }
        else {
            cell.jobTitleLabel.text = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        if section == 0 {
            return "People who wants to connect to you"
        }
        else if section == 1{
            return "People who may know"
        }
        else {
            return nil
        }
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
    
}

extension PeopleViewController : PeopleListingDelegate {
    func didTapAddFriend(atIndex indexPath: IndexPath) {
        
        let people = self.datasource [indexPath.section].people [indexPath.row]
        ActivityIndicatorManager.showActivityIndicator()
        var requests = [String] ()
        let reference = RequestType.users.reference.child(people.id!).child("requests")
        NetworkManager.getValueForSingleEvent(forReference: reference) { [unowned self] (data) in
            if let snap = data as? DataSnapshot {
                if let value = snap.value as? [Any] {
                    requests = value as! [String]
                }
                
                let id = Auth.auth().currentUser!.uid
                requests.append(id)
                let dict = ["requests" : requests]
                NetworkManager.updateInformation(forReference: RequestType.users.reference.child(people.id!), values: dict as [String : AnyObject], completion: { (response) in
                    self.peopleViewModel.changeStatus(currentStatus: .Requests, id: people.id!)
                    self.datasource [indexPath.section].people.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    ActivityIndicatorManager.dismissActivityIndicator()
                })
            }
        }
    }
    
    func didTapRemoveFriend(atIndex indexPath: IndexPath) {
        let people = self.datasource [indexPath.section].people [indexPath.row]
        peopleViewModel.changeStatus(currentStatus: .Removed, id: people.id!)
        self.datasource [indexPath.section].people.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
