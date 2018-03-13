//
//  SelectPrivacyViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 13/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class SelectPrivacyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var selectedPrivacyLevel : PrivacyLevel?
    var newPrivacyLevel : PrivacyLevel?
    var navigationType : SelectPrivacyNavigationType = .none
    var isLoading = false {
        didSet {
            if isLoading {
                self.showActivityIndicator()
                self.tableView.isUserInteractionEnabled = false
                self.tableView.visibleCells.forEach({ (cell) in
                    cell.textLabel?.alpha = 0.5
                })
            } else {
                self.hideActivityIndicator()
                self.tableView.isUserInteractionEnabled = true
                self.tableView.visibleCells.forEach({ (cell) in
                    cell.textLabel?.alpha = 1.0
                })
                self.tableView.reloadData()
            }
        }
    }
    
    var privacyLevels : [PrivacyLevel] = [.everyone, .contacts, .nobody]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = navigationType.title
        self.navigationItem.largeTitleDisplayMode = .never
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updatePrivacyLevel(){
        
    }
    
    func showActivityIndicator () {
        let activityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicatorView.frame = CGRect.init(x: 0, y: 0, width: 22, height: 22)
        activityIndicatorView.startAnimating()
        
        let titleLabel = UILabel()
        titleLabel.text = "Updating..";
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.frame = CGRect.init(x: activityIndicatorView.frame.origin.x + activityIndicatorView.frame.size.width + 8, y: activityIndicatorView.frame.origin.y, width: 80, height: activityIndicatorView.frame.size.height)
        titleLabel.sizeToFit()
        
        let titleView = UIView.init(frame: CGRect.init(x: -(activityIndicatorView.frame.size.width + 8 + titleLabel.frame.size.width)/2, y: -(activityIndicatorView.frame.size.height)/2, width: activityIndicatorView.frame.size.width + 8 + titleLabel.frame.size.width, height: activityIndicatorView.frame.size.height))
        
        titleView.addSubview(activityIndicatorView)
        titleView.addSubview(titleLabel)
        
        self.navigationItem.titleView = titleView;
    }
    
    func hideActivityIndicator() {
        self.navigationItem.titleView = nil;
    }
}

extension SelectPrivacyViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privacyLevels.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if isLoading {
            return nil
        }else{
            return indexPath;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "selectPrivacyCell", for: indexPath)
        currentCell.textLabel?.text = self.privacyLevels[indexPath.row].title
        if indexPath.row == privacyLevels.index(of: selectedPrivacyLevel!) {
            currentCell.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            currentCell.accessoryType = UITableViewCellAccessoryType.none
        }
        return currentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newPrivacyLevel = privacyLevels[indexPath.row]
        if newPrivacyLevel != selectedPrivacyLevel {
            isLoading = true
            self.updatePrivacyLevel()
        }else{
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}


