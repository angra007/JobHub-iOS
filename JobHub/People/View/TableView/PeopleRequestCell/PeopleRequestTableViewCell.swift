//
//  PeopleRequestTableViewCell.swift
//  JobHub
//
//  Created by Ankit Angra on 22/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

protocol PeopleRequestDelegate : class {
    func didTapConfirmButton (atIndexPath indexPath : IndexPath)
    func didTapRejectButton (atIndexPath indexPath : IndexPath)
}

class PeopleRequestTableViewCell: UITableViewCell, NibLoadableView {

    weak var delegate : PeopleRequestDelegate!
    var currentIndexpath : IndexPath!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    
    @IBAction func didTapRejectButton(_ sender: UIButton) {
        self.delegate.didTapRejectButton(atIndexPath: currentIndexpath)
    }
    
    @IBAction func didTapConfirmButton(_ sender: UIButton) {
        self.delegate.didTapConfirmButton(atIndexPath: currentIndexpath)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
