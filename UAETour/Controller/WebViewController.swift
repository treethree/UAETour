//
//  WebViewController.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/30/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit
import WebKit
import ProgressHUD

class WebViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    var urlStr : String = ""
    var tit : String = ""
    @IBOutlet weak var navTitle: UINavigationItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //navTitle.title = tit
        title = tit
        ProgressHUD.show()
        DispatchQueue.global().async {
            let myURL = URL(string : self.urlStr)
            let myRequest = URLRequest(url: myURL!)
            DispatchQueue.main.async {
                self.webView.load(myRequest)
                ProgressHUD.dismiss()
            } 
        }
        
        let buttonFrame = CGRect(x: 50, y: 50, width: 30, height: 30)
        let button = UIButton(frame: buttonFrame)
        button.backgroundColor = UIColor.gray
//        button.backgroundColor = UIColor(patternImage: UIImage(named: "back")!)
        //button.imageView?.image = UIImage(named: "back")
        webView.scrollView.addSubview(button)
        button.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        
    }
    @objc func buttonClicked(_ sender: AnyObject?) {
        dismiss(animated: true, completion: nil)
    }
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

}
