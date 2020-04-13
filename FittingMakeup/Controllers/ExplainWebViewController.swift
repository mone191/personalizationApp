//
//  ExplainWebViewController.swift
//  FittingMakeup
//
//  Created by 今野萌音 on 2018/09/02.
//  Copyright © 2018年 com.monek. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class ExplainWebViewController: UIViewController,WKNavigationDelegate, WKUIDelegate  {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url = ""
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        
        let request = NSURLRequest(url: URL(string: self.url)!)
        webView.load(request as URLRequest)
        
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
   

}
