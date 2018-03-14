//
//  JobTitlesViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 08/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class JobTitlesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(JobFilterTableViewCell.self)
        }
    }
    
    var selectedIndustrys = [String] ()
    var selectedTitles = [String] ()
    
    let datasource = ["Accounting Anaylst",
                      "Assistant Accounting Manager",
                      "Culture and leisure",
                      "Administrative Clerk",
                      "Administration Manager",
                      "Graphic Arts Technician",
                      "Customer Service Agent",
                      "Customer Service Analyst",
                      "Engineering Technologist",
                      "Engineering Anaylst",
                      "Data Scientist",
                      "Environmental Scientist",
                      "Technology Architect",
                      "Technology Lead",
                      "Training Consultant"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        let jobLocationViewController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobLocationController.rawValue) as! JobLocationViewController
        jobLocationViewController.selectedTitles = self.selectedTitles
        jobLocationViewController.selectedIndustrys = self.selectedIndustrys
        self.navigationController?.pushViewController(jobLocationViewController, animated: true)
    }

}

extension JobTitlesViewController : UITableViewDelegate, UITableViewDataSource {
    
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
        
        if selectedTitles.contains(jobTitle) {
            selectedTitles.remove(at: selectedTitles.index(of: jobTitle)!)
            cell.jobTitleSelectedImageView.image = nil
        }
        else {
            selectedTitles.append(jobTitle)
            cell.jobTitleSelectedImageView.image = UIImage.init(named: "ic_check_circle_white_")
        }
        
        self.jobTitleLabel.text =  String (selectedTitles.count) + " Job Titles Selected"
    }
    
    
    
}






