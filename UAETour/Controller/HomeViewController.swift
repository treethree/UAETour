//
//  HomeViewController.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/29/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var settingView: UIView!
    var attrArray : Attraction = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        tblView.backgroundView = UIImageView(image: UIImage(named: "bg"))
        settingView.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        apiHandlerCall()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attrArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as? AttractionTableViewCell
        let objc = attrArray[indexPath.row]
        cell?.titleLbl.text = "Name: \(objc.title)"
        cell?.descLbl.text = "\(objc.description)"
        cell?.contactLbl.text = "Contact: \(objc.contact)"
        cell?.timeLbl.text = "Timing: \(objc.timing)"
        cell?.distLbl.text = "Distance: 0 KM"
        
        cell?.mapBtnLbl.tag = indexPath.row
        cell?.webBtnLbl.tag = indexPath.row
        
        DispatchQueue.global().async {
            let url = URL(string: objc.image)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                if let imageData = data {
                    cell?.imgView.image = UIImage(data: imageData)
                    cell?.imgView.roundedImage()
                    cell?.backgroundView = UIImageView(image: UIImage(named: "bg"))
                }
            }
        }
        ProgressHUD.dismiss()
        
        return cell!
    }

    
    func apiHandlerCall(){
        APIHandler.sharedInstance.getAttractions(email: "tree@gmail.com") { (attr, error) in
            self.attrArray = attr!
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
    @IBAction func mapBtnClick(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        vc?.lat = Double(attrArray[sender.tag].latitude)!
        vc?.lon = Double(attrArray[sender.tag].longitude)!
        vc?.tit = attrArray[sender.tag].title
        present(vc!, animated: true, completion: nil)
//        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func webBtnClick(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController
        vc?.urlStr = attrArray[sender.tag].sitelink
        vc?.tit = attrArray[sender.tag].title
//        navigationController?.pushViewController(vc!, animated: true)
        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func settingBtnClick(_ sender: UIButton) {
    }
    
}
