//
//  LoginViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 07/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
  
    @IBAction func didTapOnForgotPassword(_ sender: UIButton) {
    }
    @IBAction func didTapLoginButton(_ sender: UIButton) {
    
        
        let jobTitleViewController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobIndustryController.rawValue)
        let jobTitleNavigationController = UINavigationController.init(rootViewController: jobTitleViewController)
        self.navigationController?.present(jobTitleNavigationController, animated: true, completion: nil)
//        if emailTextField.text?.isBlank == true {
//            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please enter your email.")
//        }
//        else if passwordTextField.text?.isBlank == true {
//            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please enter your password.")
//        }
//        else {
//            ActivityIndicatorManager.showActivityIndicator(inViews: self.view)
//            NetworkManager.login(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user) in
//                ActivityIndicatorManager.dismissActivityIndicator(fromView: self.view)
//
//                // is first login
//                    // ask choice
//                // show search directly
//
//
//            })
//
//
//            let jobTitleViewController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobTitleController.rawValue)
//            self.navigationController?.pushViewController(jobTitleViewController, animated: true)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}
