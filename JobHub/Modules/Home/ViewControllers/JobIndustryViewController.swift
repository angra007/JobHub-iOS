//
//  JobIndustryViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 08/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class JobIndustryViewController: UIViewController {

    @IBOutlet weak var selectedJobIndustryLabel: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
    }
    
}

extension JobIndustryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        
        return cell
    }
}

