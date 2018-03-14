//
//  ContactListTableViewCell.swift
//  Radar Locator
//
//  Created by Ankit Angra on 20/11/17.
//  Copyright © 2017 Radar Labs Pvt Ltd. All rights reserved.
//

import UIKit

class ContactListTableViewCell: UITableViewCell, NibLoadableView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
