//
//  ProfileTableViewCell.swift
//  Radar Locator
//
//  Created by Yogesh Choudhary on 29/11/17.
//  Copyright © 2017 Radar Labs Pvt Ltd. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
