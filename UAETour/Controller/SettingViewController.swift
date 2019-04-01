//
//  SettingViewController.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/31/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblView: UITableView!

    @IBOutlet weak var titView: UILabel!
    var setArray : Array<String> = ["USER PROFILE", "LOGOUT"]
    
    @IBOutlet var setView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SETTING"
        tblView.backgroundView = UIImageView(image: UIImage(named: "bg"))
        setView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        //titView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "settingCell")
        cell?.textLabel!.text = setArray[indexPath.row]

        cell?.backgroundView = UIImageView(image: UIImage(named: "bg"))
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if setArray[indexPath.row] == "USER PROFILE"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
            vc?.fName = loginUser!.fName!
            vc?.lName = loginUser!.lName!
            vc?.email = loginUser!.emailId!
            vc?.phone = loginUser!.mobile!
            vc?.dob = loginUser!.dob!
            navigationController?.pushViewController(vc!, animated: true)
        }else{
            //Log out
            loginUser = nil
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            present(vc!, animated: true, completion: nil)
        }
        
    }

}
