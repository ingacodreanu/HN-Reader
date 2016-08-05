//
//  DetailArticlesViewController.swift
//  testApp
//
//  Created by Codreanu Inga on 8/4/16.
//  Copyright © 2016 Codreanu Inga. All rights reserved.
//

import UIKit

class DetailArticlesViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var webView: UIWebView!
    var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            webView.loadRequest(NSURLRequest(URL: NSURL(string: urlString)!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        loading.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        loading.stopAnimating()
        loading.hidesWhenStopped = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
