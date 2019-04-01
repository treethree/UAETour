//
//  ProfileViewController.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/29/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var fNameText: UITextField!
    @IBOutlet weak var lNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var dobText: UITextField!
    
    var fName : String = ""
    var lName : String = ""
    var email : String = ""
    var phone : String = ""
    var dob : String = ""
    
    var updatedCustomer : User?
    var str : String = ""
    let objValidation = Validation()
    var emailValRes : Bool = false
    var pwValRes : Bool = false
    var fnameValRes : Bool = false
    var lnameValRes : Bool = false
    var phoneValRes : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EDIT PROFILE"
        fNameText.text = fName
        lNameText.text = lName
        emailText.text = email
        phoneText.text = phone
        dobText.text = dob
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatedCustomer = User.init( id: loginUser?.id,fName: fNameText.text, lName: lNameText.text, emailId: emailText.text, mobile: phoneText.text, paswd: loginUser?.paswd, dob: dobText.text, gender: loginUser?.gender)
        switch textField{
        case emailText:
            emailValRes = objValidation.emailValidation(textField: emailText, str: str)
        case fNameText:
            fnameValRes = objValidation.firstNameValidation(textField: fNameText, str: str)
        case lNameText:
            fnameValRes = objValidation.firstNameValidation(textField: lNameText, str: str)
        case phoneText:
            phoneValRes = objValidation.phoneNumberValidation(textField: phoneText, str: str)
        default:
            print("Do nothing")
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        str = String(format: "%@%@", textField.text!, string)
        return true
    }
    
    @IBAction func submitbtnClick(_ sender: UIButton) {
        //make sure last text field get triggered when login button clicked.
        view.endEditing(true)
        
        APIHandler.sharedInstance.updateUser(user: updatedCustomer!) { (info, error) in
           // print("info is \(info)")
        }
    }
}
