//
//  RegistrationViewController.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/29/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit
import DLRadioButton

class RegistrationViewController: UIViewController,UITextFieldDelegate {

    var customer : User?
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var cpwTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    var gender : String = ""
    var str : String = ""
    let objValidation = Validation()
    var emailValRes : Bool = false
    var pwValRes : Bool = false
    var fnameValRes : Bool = false
    var lnameValRes : Bool = false
    var phoneValRes : Bool = false
    
    var datePicker : UIDatePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SIGN UP"
        pwTextField.isSecureTextEntry = true
        cpwTextField.isSecureTextEntry = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
        // DOB: embed date picker in textField
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(RegistrationViewController.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegistrationViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        dobTextField.inputView = datePicker
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dobTextField.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        customer = User.init( fName: fNameTextField.text, lName: lNameTextField.text, emailId: emailTextField.text, mobile: phoneTextField.text, paswd: pwTextField.text, dob: dobTextField.text, gender: gender)
        switch textField{
        case emailTextField:
            emailValRes = objValidation.emailValidation(textField: emailTextField, str: str)
        case pwTextField:
            pwValRes = objValidation.passwordValidation(textField: pwTextField, str: str)
        case cpwTextField:
            pwValRes = objValidation.passwordValidation(textField: cpwTextField, str: str)
        case fNameTextField:
            fnameValRes = objValidation.firstNameValidation(textField: fNameTextField, str: str)
        case lNameTextField:
            lnameValRes = objValidation.firstNameValidation(textField: lNameTextField, str: str)
        case phoneTextField:
            phoneValRes = objValidation.phoneNumberValidation(textField: phoneTextField, str: str)
        default:
            print("Do nothing")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        str = String(format: "%@%@", textField.text!, string)
        return true
    }

    @IBAction func genderBtnClick(_ sender: DLRadioButton) {
        switch sender.tag{
        case 1:
            gender = "Male"
            print(gender)
        default:
            gender = "Female"
        }
        view.endEditing(true)
    }
    
    @IBAction func submitBtnClick(_ sender: UIButton) {
        //make sure last text field get triggered when login button clicked.
        view.endEditing(true)
        customer?.gender = gender
        if emailValRes && pwValRes && fnameValRes && lnameValRes && phoneValRes{
            APIHandler.sharedInstance.registration(user: customer!) { (info, error) in
                // create the alert
                let alert = UIAlertController(title: "Registration Status", message: info, preferredStyle: UIAlertController.Style.alert)
                
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { action in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                    self.present(vc!, animated: true)
                    
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                //print(info)
            }
        }else{
            let alert = UIAlertController(title: "Registration Error", message: "Error Input Value", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
