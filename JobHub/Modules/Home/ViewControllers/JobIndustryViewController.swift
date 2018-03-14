//
//  JobIndustryViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 08/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class JobIndustryViewController: UIViewController {
    
    var selectedIndustry = [String] ()

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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        let jobTitleViewController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobTitleController.rawValue) as! JobTitlesViewController
        jobTitleViewController.selectedIndustrys = self.selectedIndustry
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

