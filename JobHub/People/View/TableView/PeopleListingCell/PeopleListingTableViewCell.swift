//
//  PeopleListingTableViewCell.swift
//  JobHub
//
//  Created by Ankit Angra on 14/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

protocol PeopleListingDelegate : class {
    func didTapAddFriend (atIndex index : IndexPath)
    func didTapRemoveFriend (atIndex index : IndexPath)
}

class PeopleListingTableViewCell: UITableViewCell, NibLoadableView {

    weak var delegate : PeopleListingDelegate!
    
    var currentIndex : IndexPath!
    
    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        self.delegate.didTapRemoveFriend(atIndex: currentIndex)
    }
    
    @IBAction func didTapConfirmButton(_ sender: UIButton) {
        self.delegate.didTapAddFriend(atIndex: currentIndex)
    }
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
