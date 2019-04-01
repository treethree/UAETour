//
//  LoginViewController.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/29/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit
import SwiftValidator

var loginUser : User?


class LoginViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var signinBtnOutlet: UIButton!
    
    var userN : String?
    var passW : String?
    var str : String = ""
    let objValidation = Validation()
    var emailValRes : Bool = false
    var pwValRes : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pwTextField.isSecureTextEntry = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userN = emailTextField.text
        passW = pwTextField.text
        switch textField{
        case emailTextField:
            emailValRes = objValidation.emailValidation(textField: emailTextField, str: str)
        default:
            pwValRes = objValidation.passwordValidation(textField: pwTextField, str: str)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        str = String(format: "%@%@", textField.text!, string)
        return true
    }


    @IBAction func signinBtnClick(_ sender: UIButton) {
        //make sure last text field get triggered when login button clicked.
        view.endEditing(true)
        if emailValRes && pwValRes{
        APIHandler.sharedInstance.login(userName: userN!, withPassword: passW!) { (user, error) in

            if user == nil{
                // create the alert
                let alert = UIAlertController(title: "Sign In Error", message: error, preferredStyle: UIAlertController.Style.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }else{
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController{
                    self.present(vc, animated: true, completion: nil)
                    loginUser = user
                    //print(loginUser)
                }
            }
        }
        }else{
            let alert = UIAlertController(title: "Sign In Error", message: "error input value", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    


}
