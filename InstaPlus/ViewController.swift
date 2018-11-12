//
//  ViewController.swift
//  InstaPlus
//
//  Created by MAC on 11/11/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import WebKit
import SystemConfiguration
import RSLoadingView

class ViewController: UIViewController , UIWebViewDelegate {
    
    
    @IBOutlet weak var web: UIWebView!
    let loadingProgress = LoadingProgress()
    let url_string = "https://www.instapluskw.me/backup/Apps/"
    override func viewDidLoad() {
        super.viewDidLoad()
        web.delegate = self
        loadingProgress.showLoadingHub(view: view)
        if(isConnectionAvailble()) {
            viewContent()
        }else{
            
            let alert = UIAlertController(title: "Connection error", message: "Check Your network connection", preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if(isConnectionAvailble()) {
            viewContent()
        }else{
            
            let alert = UIAlertController(title: "Connection error", message: "Check Your network connection", preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    fileprivate func viewContent()
    {
        
        let url = URL(string: url_string);
        let request = URLRequest(url: url!)
        web.loadRequest(request)
        
        
        
    }
    
    
    
    func webViewDidStartLoad(_ webView : UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //loadingProgress.showLoadingHub(view: view)
    }
    
    func webViewDidFinishLoad(_ webView : UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        loadingProgress.hideLoadingHub(view: view)
        
    }
    
    
    
    
    
    func isConnectionAvailble()->Bool{
        
        let rechability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "www.apple.com")
        
        var flags : SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
        
        if SCNetworkReachabilityGetFlags(rechability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }


}

