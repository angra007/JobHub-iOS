//
//  JobIndustryViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 08/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit
import Firebase

class JobIndustryViewController: UIViewController {
    
    var selectedIndustry = [String] ()

    var userDict : [String : AnyObject]!
    
    var isFromSetting = false
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottonViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedJobIndustryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(JobFilterTableViewCell.self)
        }
    }
    
    
    let datasource = ["Accounting and Finance", "Administrative and Clerical", "Media and Entertainment", "Customer Service", "Engineering", "Environmental", "Financial Services", "Healthcare Services and Wellness", "Insurance", "Legal", "Manufacturing", "Sales and Business" , "Development"
        ,"Science and research"
        ,"Technology and Digital Media"
        ,"Training and Education"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(JobFilterTableViewCell.self)
        self.navigationItem.largeTitleDisplayMode = .never
        
        if isFromSetting == true {
            bottomView.isHidden = true
            
            let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector (didTapDoneButton))
            self.navigationItem.rightBarButtonItems = [doneButton]
            
            let userReference = RequestType.profile.reference.child("intrestedIndusties")
            ActivityIndicatorManager.showActivityIndicator()
            NetworkManager.getValueForSingleEvent(forReference:userReference , completion: { [unowned self] (response) in
                ActivityIndicatorManager.dismissActivityIndicator()
                if let snapShot = response as? DataSnapshot {
                    if let value = snapShot.value as? [String] {
                        self.selectedIndustry = value
                    }
                }
                self.tableView.reloadData()
            })
        }
        else {
            bottomView.isHidden = false
        }
        // Do any additional setup after loading the view.
    }

    
    @objc func didTapDoneButton () {
        let userReference = RequestType.profile.reference
        let values = ["intrestedIndusties" : self.selectedIndustry]
        ActivityIndicatorManager.showActivityIndicator()
        NetworkManager.updateInformation(forReference: userReference, values: values as [String : AnyObject]) { (response) in
            ActivityIndicatorManager.dismissActivityIndicator()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "JobSearchChnaged"), object: nil)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        let jobTitleViewController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobTitleController.rawValue) as! JobTitlesViewController
        userDict ["intrestedIndusties"] = self.selectedIndustry as AnyObject
        jobTitleViewController.userDict = userDict
        self.navigationController?.pushViewController(jobTitleViewController, animated: true)
    }
    
}

extension JobIndustryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : JobFilterTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
        cell.jobTitleLabel.text = datasource [indexPath.row]
        
        if selectedIndustry.contains(datasource [indexPath.row]) {
            cell.jobTitleSelectedImageView.image = UIImage.init(named: "ic_check_circle_white_")
        }
        else {
            cell.jobTitleSelectedImageView.image = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jobTitle = datasource[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! JobFilterTableViewCell
        
        if selectedIndustry.contains(jobTitle) {
            selectedIndustry.remove(at: selectedIndustry.index(of: jobTitle)!)
            cell.jobTitleSelectedImageView.image = nil
        }
        else {
            selectedIndustry.append(jobTitle)
            cell.jobTitleSelectedImageView.image = UIImage.init(named: "ic_check_circle_white_")
        }
        self.selectedJobIndustryLabel.text = String (selectedIndustry.count) + " Job Titles Selected"
    }
    
}

