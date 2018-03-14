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
  
    func textFieldHandler(textField: UITextField!)
    {
        if (textField) != nil {
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
        }
    }
    
    @IBAction func didTapOnForgotPassword(_ sender: UIButton) {
        let alert = UIAlertController(title: "Forgot your password?", message: "We will send a recovery email to your registered email address. Please enter your email address", preferredStyle:
            UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: textFieldHandler)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            let emailTextfield = alert.textFields![0] as UITextField
            
            if let email = emailTextfield.text {
                ActivityIndicatorManager.showActivityIndicator()
                NetworkManager.forgotPassword(withEmail: email, completion: { (error) in
                    ActivityIndicatorManager.dismissActivityIndicator()
                    if error == nil {
                        AlertManager.showAlert(inViewController: self, withTitle: "", message: "Recovery link sent successfully")
                    }
                    else {
                        AlertManager.showAlert(inViewController: self, withTitle: "", message: "Something went wrong. Please try again.")
                    }
                })
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:{ (UIAlertAction)in
            
            
        }))
        
        self.present(alert, animated: true, completion:nil)
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
        if emailTextField.text?.isBlank == true {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please enter your email.")
        }
        else if passwordTextField.text?.isBlank == true {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please enter your password.")
        }
        else {
            ActivityIndicatorManager.showActivityIndicator(inViews: self.view)
            NetworkManager.login(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user) in
                ActivityIndicatorManager.dismissActivityIndicator(fromView: self.view)

                let jobTabViewController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobTabBarController.rawValue)
                self.navigationController?.present(jobTabViewController, animated: true, completion: nil)
                
            })
        }
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
