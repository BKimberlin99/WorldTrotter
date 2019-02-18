//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Brandon Kimberlin on 2/18/19.
//  Copyright © 2019 Brandon Kimberlin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func loadView() {
 
        webView = WKWebView()
        
        view = webView
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.bignerdranch.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        view = webView
        
        print("WebViewController loaded its view")
    }
}
