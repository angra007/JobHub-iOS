//
//  JobLocationViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 08/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class JobLocationViewController: UIViewController {


    var selectedLocations = [String] ()
    
    var userDict : [String : AnyObject]!
    
    let datasource = ["Barrie",
                      "Brampton",
                      "Burlington",
                      "Cambridge",
                      "Guelph",
                      "Hamilton",
                      "Kitchener",
                      "London",
                      "North York",
                      "Mississauga",
                      "Ottawa",
                      "Scarborough",
                      "Toronto",
                      "Vaughan",
                      "Waterloo"]
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(JobFilterTableViewCell.self)
        }
    }
    

    @IBOutlet weak var selectedLocationLabel: UILabel!
    @IBAction func didTapNextButton(_ sender: UIButton) {
        
        userDict ["intrestLocation"] = self.selectedLocations as AnyObject
        
        ActivityIndicatorManager.showActivityIndicator()
        NetworkManager.updateInformation(forRequestType: .profile, values: userDict as [String : AnyObject], completion: { [unowned self] (databaseReference) in
            ActivityIndicatorManager.dismissActivityIndicator()
            let jobSearchViewController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobTabBarController.rawValue)
            self.navigationController?.isNavigationBarHidden = true
            self.addChildController(childController: jobSearchViewController, inContentView: self.view)
        })
    }
    
    
    func addChildController(childController : UIViewController , inContentView contentView : UIView) -> Void {
        childController.willMove(toParentViewController: self)
        childController.view.frame = contentView.bounds
        self.addChildViewController(childController)
        contentView.addSubview(childController.view)
        childController.didMove(toParentViewController: self)
        //        childController.beginAppearanceTransition(true, animated: true)
    }
    
    func removeChildController(childController : UIViewController) -> Void {
        childController.willMove(toParentViewController: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParentViewController()
    }
    
    
}

extension JobLocationViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : JobFilterTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
        cell.jobTitleLabel.text = datasource [indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jobTitle = datasource[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! JobFilterTableViewCell
        
        if selectedLocations.contains(jobTitle) {
            selectedLocations.remove(at: selectedLocations.index(of: jobTitle)!)
            cell.jobTitleSelectedImageView.image = nil
        }
        else {
            selectedLocations.append(jobTitle)
            cell.jobTitleSelectedImageView.image = UIImage.init(named: "ic_check_circle_white_")
        }
        
        self.selectedLocationLabel.text =  String (selectedLocations.count)  + " Job Titles Selected"
    }
}
