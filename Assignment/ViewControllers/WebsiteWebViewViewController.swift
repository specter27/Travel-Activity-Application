//
//  WebsiteWebViewViewController.swift
//  Assignment
//
//  Created by Nirav Kumbhare on 2022-04-03.
//

import UIKit
import WebKit

class WebsiteWebViewViewController: UIViewController, WKNavigationDelegate {
    //properties
    var webView: WKWebView!
    var webUrl:String = ""
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "\(webUrl)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
