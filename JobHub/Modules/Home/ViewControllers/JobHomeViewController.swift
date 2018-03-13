//
//  JobHomeViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 09/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class JobHomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let jobSearchViewController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobSearchController.rawValue)
        let chatViewController = UIStoryboard.chatStoryboard().instantiateInitialViewController()!
        let contactsController = UIStoryboard.contactsStoryboard().instantiateInitialViewController()!
        let settingLandingController = UIStoryboard.settingsStoryboard().instantiateInitialViewController()!
        
        
        let tabOneBarItem1 = UITabBarItem.init(title: "Home", image: UIImage(named : "home"), tag: 0)
        let tabOneBarItem2 = UITabBarItem.init(title: "Chat", image: UIImage(named : "chat"), tag: 0)
        let tabOneBarItem3 = UITabBarItem.init(title: "Contacts", image: UIImage(named : "contacts"), tag: 0)
        let tabOneBarItem4 = UITabBarItem.init(title: "Settings", image: UIImage(named : "settings"), tag: 0)
        
        jobSearchViewController.tabBarItem = tabOneBarItem1
        chatViewController.tabBarItem = tabOneBarItem2
        contactsController.tabBarItem = tabOneBarItem3
        settingLandingController.tabBarItem = tabOneBarItem4
        //
        self.viewControllers = [jobSearchViewController, chatViewController, contactsController, settingLandingController]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.hidesBackButton = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
