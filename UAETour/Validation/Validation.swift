//
//  Validation.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/31/19.
//  Copyright © 2019 scui5. All rights reserved.
//
import UIKit
import Foundation


class Validation{
    func setupAlertLabel(label:UILabel, textField:UITextField) {
        label.topAnchor.constraint(equalTo: textField.topAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: textField.centerXAnchor, constant: -20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    var emailAlertLabel: UILabel = {
        let alertLabel = UILabel()
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.numberOfLines = 0;
        alertLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 12)
        alertLabel.text = "Invalid email format"
        alertLabel.textColor = .red
        return alertLabel
    }()
    
    func emailValidation(textField : UITextField, str : String)->Bool{
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = emailTest.evaluate(with: str)
        if !isValid {
            textField.addSubview(emailAlertLabel)
            setupAlertLabel(label: emailAlertLabel, textField: textField)
            emailAlertLabel.isHidden = false
            return false
        } else {
            emailAlertLabel.isHidden = true
            return true
        }
    }
    
    var passwordAlertLabel: UILabel = {
        let alertLabel = UILabel()
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.numberOfLines = 0;
        alertLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 12)
        alertLabel.text = "Need 3 characters, Must contain at least one lower case letter, upper case letter and digit"
        alertLabel.textColor = .red
        return alertLabel
    }()
    
    func passwordValidation(textField : UITextField, str : String)->Bool{
        let regex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{3,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = passwordTest.evaluate(with: str)
        
        if !isValid {
            textField.addSubview(passwordAlertLabel)
            setupAlertLabel(label: passwordAlertLabel, textField: textField)
            passwordAlertLabel.isHidden = false
            return false
        } else {
            passwordAlertLabel.isHidden = true
            return true
        }
    }
    var phoneNumberAlertLabel: UILabel = {
        let alertLabel = UILabel()
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.numberOfLines = 0;
        alertLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 12)
        alertLabel.text = "Mobile phone must contains 3-13 numbers"
        alertLabel.textColor = .red
        return alertLabel
    }()
    
    func phoneNumberValidation(textField : UITextField, str : String)->Bool{
        let regex = "^[0-9]{3,13}$"
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = mobileTest.evaluate(with: str)
        
        if !isValid {
            textField.addSubview(phoneNumberAlertLabel)
            setupAlertLabel(label: phoneNumberAlertLabel, textField: textField)
            phoneNumberAlertLabel.isHidden = false
            return false
        } else {
            phoneNumberAlertLabel.isHidden = true
            return true
        }
    }
    
    var firstNameAlertLabel: UILabel = {
        let alertLabel = UILabel()
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.numberOfLines = 0;
        alertLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 12)
        alertLabel.text = "Name must contains 3-30 characters"
        alertLabel.textColor = .red
        return alertLabel
    }()
    
    func firstNameValidation(textField : UITextField, str : String)->Bool{
        let regex = "^[a-zA-Z]{3,30}$"
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = mobileTest.evaluate(with: str)
        
        if !isValid {
            textField.addSubview(firstNameAlertLabel)
            setupAlertLabel(label: firstNameAlertLabel, textField: textField)
            firstNameAlertLabel.isHidden = false
            return false
        } else {
            firstNameAlertLabel.isHidden = true
            return true
        }
    }
    

}
