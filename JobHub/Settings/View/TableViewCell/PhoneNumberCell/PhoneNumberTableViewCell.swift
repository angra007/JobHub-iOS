//
//  PhoneNumberTableViewCell.swift
//  Radar Locator
//
//  Created by Yogesh Choudhary on 03/12/17.
//  Copyright © 2017 Radar Labs Pvt Ltd. All rights reserved.
//

import UIKit


class PhoneNumberTableViewCell: UITableViewCell, NibLoadableView {
    @IBOutlet weak var countryCodeTextfield: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
