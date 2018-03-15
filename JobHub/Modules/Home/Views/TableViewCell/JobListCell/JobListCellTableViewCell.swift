//
//  JobListCellTableViewCell.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class JobListCellTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
