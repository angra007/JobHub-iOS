//
//  SettingsLandingViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 12/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class SettingsLandingViewController: UIViewController {
    
    fileprivate var name : String = "Ankit"
    fileprivate var imageTag : String?
    fileprivate var status : String = "Available"
    fileprivate var isLighteningModeOn : Bool!
    
    enum CellType {
        
        case profile
        case lighteningMode
        case savedLocation
        case account
        case notification
        case about
        case invite
        
        var label : String? {
            switch self {
            case .profile:
                return nil
            case .lighteningMode:
                return "Lightening Mode"
            case .savedLocation:
                return "Saved Jobs"
            case .account:
                return "Account"
            case .notification:
                return "Notification"
            case .about:
                return "About and Help"
            case .invite:
                return "Invite a Friend"
            }
        }
        
        var icon : UIImage? {
            switch self {
            case .profile:
                return nil
            case .lighteningMode:
                return UIImage.init(named: "lightening")
            case .savedLocation:
                return UIImage.init(named: "saved")
            case .account:
                return UIImage.init(named: "account")
            case .notification:
                return UIImage.init(named: "notification")
            case .about:
                return UIImage.init(named: "about")
            case .invite:
                return UIImage.init(named: "invite")
            }
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(ProfileTableViewCell.self)
        }
    }
    
    fileprivate var datasource = [[CellType]] ()
    
    fileprivate func constructDatasource () {
        var sectionOne = [CellType] ()
        sectionOne.append(.profile)
        datasource.append(sectionOne)
        
        
        
        var sectionThree = [CellType] ()
        sectionThree.append(.account)
        sectionThree.append(.savedLocation)
        sectionThree.append(.notification)
        datasource.append(sectionThree)
        
        var sectionFour = [CellType] ()
        sectionFour.append(.about)
        sectionFour.append(.invite)
        datasource.append(sectionFour)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constructDatasource ()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.hidesBackButton = false
    }
}

extension SettingsLandingViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let item = datasource[section]
        if item.contains(.lighteningMode){
            return "To share your location three times faster. This might impact device's battery performance."
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .lighteningMode:
            return false
        default:
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .lighteningMode:
            return nil
        default:
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        var cell : UITableViewCell!
        switch type {
        case .profile:
            let currentCell : ProfileTableViewCell = tableView.dequeuResuableCell(forIndexPath: indexPath)
            currentCell.nameLabel.text = self.name
            //currentCell.profileImageView.sd_setIndicatorStyle(.gray)
//            currentCell.profileImageView.sd_addActivityIndicator()
//            if self.imageTag != nil {
//                currentCell.profileImageView.sd_showActivityIndicatorView()
//
//                CloudnaryHelper.getURL(withTag: self.imageTag!, size: 60, withCompletion: { (url) in
//                    if let urlString = url {
//                        if let url = URL.init(string:urlString ) {
//                            currentCell.profileImageView.sd_setImage(with: url, placeholderImage: nil, options: .progressiveDownload, completed: { (image, error, cacheType, url) in
//                                if error != nil {
//                                    currentCell.profileImageView.image = UIImage(named : "user")
//                                }
//                                currentCell.profileImageView.sd_removeActivityIndicator()
//                            })
//                        }
//                    }
//                })
//
//
//            }else{
//                currentCell.profileImageView.sd_removeActivityIndicator()
//                currentCell.profileImageView.image = UIImage(named : "user")
//            }
            currentCell.profileImageView.image = UIImage(named : "user")
            currentCell.statusLabel.text = self.status
            currentCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell = currentCell
            break
        case .lighteningMode:
            let currentCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
//            currentCell.imageView?.image = type.icon
//            currentCell.textLabel?.text = type.label
//
//            let switchView = UISwitch.init(frame: CGRect.zero)
//            currentCell.accessoryView = switchView
//            switchView.addTarget(self, action: #selector(self.didTapLighteningModeSwitch), for: .valueChanged)
//            if self.isLighteningModeOn {
//                switchView.setOn(true, animated: false)
//            }
            cell = currentCell
            break
        default:
            let currentCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
            currentCell.imageView?.image = type.icon
            currentCell.textLabel?.text = type.label
            currentCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell = currentCell
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = datasource[indexPath.section]
        let type = item[indexPath.row]
        switch type {
        case .profile:
//            let profileController = UIStoryboard.settingStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.profileController.rawValue) as! ProfileViewController
//            profileController.navigationType = .settings
//            self.navigationController?.pushViewController(profileController, animated: true)
            break
        case .savedLocation:
//            let saveLocationVC = UIStoryboard.settingStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.savedLocationController.rawValue)
//            self.navigationController?.pushViewController(saveLocationVC, animated: true)
            break
        case .account:
            let accountViewController = UIStoryboard.settingsStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.AccountController.rawValue)
            self.navigationController?.pushViewController(accountViewController, animated: true)
            break
        case .notification:
            break
        case .about:
//            let aboutViewController = UIStoryboard.settingStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.aboutController.rawValue) as! AboutViewController
//            self.navigationController?.pushViewController(aboutViewController, animated: true)
            break
        case .invite:
            let activityViewController = UIActivityViewController(activityItems: [ "Checkout out Radar Locator for your smartphone. Download it today from https://goo.gl/jQT4jg" ], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



