//
//  RegistrationViewController.swift
//  JobHub
//
//  Created by Ankit Angra on 14/03/18.
//  Copyright © 2018 Ankit Angra. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    var userDict : [String : AnyObject]!
    
    
    @IBOutlet weak var contactNumberTextfield: UITextField!
    @IBOutlet weak var contactLocationTextfield: UITextField!
    @IBOutlet weak var industryTextfield: UITextField!
    @IBOutlet weak var currentSkillsTextfield: UITextField!
    @IBOutlet weak var workExperienceTextfield: UITextField!
    @IBOutlet weak var currentOrganisationTextfield: UITextField!
    @IBOutlet weak var jobTitleTextField: UITextField!
    
    var industryPicker : UIPickerView!
    
    fileprivate var industryArray = ["Accounting and Finance", "Administrative and Clerical", "Media and Entertainment", "Customer Service", "Engineering", "Environmental", "Financial Services", "Healthcare Services and Wellness", "Insurance", "Legal", "Manufacturing", "Sales and Business" , "Development"
        ,"Science and research"
        ,"Technology and Digital Media"
        ,"Training and Education"]
    
    fileprivate var contactNumber : String?
    fileprivate var currentLocation : String?
    fileprivate var currentIndustry : String?
    fileprivate var workExperience : String?
    fileprivate var currentOrganisation : String?
    fileprivate var currentSkills : String?
    fileprivate var currentJobTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Complete Your Registration"
        
        self.contactNumberTextfield.delegate = self
        self.contactLocationTextfield.delegate = self
        self.industryTextfield.delegate = self
        self.currentSkillsTextfield.delegate = self
        self.workExperienceTextfield.delegate = self
        self.currentOrganisationTextfield.delegate = self
        self.jobTitleTextField.delegate = self
        
        industryPicker = UIPickerView ()
        industryPicker.delegate = self
        industryTextfield.inputView = industryPicker
    }
    
    @IBAction func didTapNextButton(_ sender: UIButton) {
        
        if contactNumber == nil || contactNumber?.isBlank == true {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please enter your contact number")
        }
        else if currentLocation == nil || currentLocation?.isBlank == true {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please enter your location")
        }
        else if currentJobTitle == nil || currentLocation?.isBlank == true {
            AlertManager.showAlert(inViewController: self, withTitle: "Error", message: "Please enter your current job title. If you are not working please enter N/A")
        }
        else {
           
            userDict ["phoneNumber"] = contactNumber as AnyObject
            userDict ["location"] = currentLocation as AnyObject
            userDict ["jobTitle"] = currentJobTitle as AnyObject
            
            if let industry = currentIndustry {
                userDict ["industry"] = industry as AnyObject
            }
            else {
                userDict ["industry"] = "" as AnyObject
            }
            
            if let workExp = workExperience {
                userDict ["workExperience"] = workExp as AnyObject
            }
            else {
                userDict ["workExperience"] = "" as AnyObject
            }
            
            if let currentOrg = currentOrganisation {
                userDict ["organisation"] = currentOrg as AnyObject
            }
            else {
                userDict ["organisation"] = "" as AnyObject
            }
            
            if let currentSkill = currentSkills {
                userDict ["skills"] = currentSkill as AnyObject
            }
            else {
                userDict ["skills"] = "" as AnyObject
            }
            
            let jobTitleViewController = UIStoryboard.homeStoryboard().instantiateViewController(withIdentifier: UIStoryboard.StoryboardIdentifiers.JobIndustryController.rawValue) as! JobIndustryViewController
            jobTitleViewController.userDict = userDict
            self.navigationController?.pushViewController(jobTitleViewController, animated: true)
        }
    }
}

extension RegistrationViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return industryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return industryArray [row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.industryTextfield.text = industryArray [row]
    }
}

extension RegistrationViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tag = textField.tag
        switch  tag {
        case 1:
            contactNumber = textField.text
            break
        case 2:
            currentLocation = textField.text
            break
        case 3:
            currentIndustry = textField.text
            break
        case 4:
            workExperience = textField.text
            break
        case 5:
            currentOrganisation = textField.text
            break
        case 6:
            currentSkills = textField.text
            break
        case 7:
            currentJobTitle = textField.text
        default:
            break
        }
    }
    
}




