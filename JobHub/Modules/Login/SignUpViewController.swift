//
//  SignUpViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 07/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    fileprivate var firstName : String?
    fileprivate var secondName : String?
    fileprivate var email : String?
    fileprivate var password : String?
    fileprivate var confirmPassword : String?
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        
        if firstName == nil || firstName?.isBlank == true {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please Enter First Name.")
        }
        else if secondName == nil || secondName?.isBlank == true {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please Enter Second Name.")
        }
        else if email == nil || email?.isBlank == true {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please Enter Email.")
        }
        else if password == nil || password?.isBlank == true {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please Enter Password.")
        }
        else if password != confirmPassword {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Password doesn't match")
        }
        else {
            ActivityIndicatorManager.showActivityIndicator()
            NetworkManager.register(withEmail: email!, password: password!, completion: { (user) in
                ActivityIndicatorManager.dismissActivityIndicator()
            })
        }
    }
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameTextfield.delegate = self
        self.secondNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextfield.delegate = self
        self.confirmPasswordTextField.delegate = self
       // self.navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }

}

extension SignUpViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            self.firstName = textField.text
        case 2:
            self.secondName = textField.text
        case 3:
            self.email = textField.text
        case 4:
            self.password = textField.text
        case 5:
            self.confirmPassword = textField.text
        default:
            break
        }
    }
}
