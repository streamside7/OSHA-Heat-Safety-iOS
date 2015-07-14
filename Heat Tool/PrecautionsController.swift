//
//  PrecautionsController.swift
//  Heat Tool
//
//  Created by E J Kalafarski on 2/17/15.
//  Copyright (c) 2015 OSHA. All rights reserved.
//

import UIKit

class PrecautionsController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var precautionLevel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.delegate = self
        
        // Get the contents of the file to load
        let localFilePath = NSBundle.mainBundle().pathForResource(precautionLevel, ofType: "html")
        var contents: NSString?
        do {
            contents = try NSString(contentsOfFile: localFilePath!, encoding: NSUTF8StringEncoding)
        } catch _ {
            contents = nil
        }
        
        // Get the base URL of the file so we can access its resources
        let baseUrl = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
        
        // Load contents into the webview
        webView.loadHTMLString(contents as! String, baseURL: baseUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType nt: UIWebViewNavigationType) -> Bool {
        // If it's a web link
        if request.URL!.scheme == "http" {
            UIApplication.sharedApplication().openURL(request.URL!)
            return false
        }
        
        // If it's a local link
        if nt == UIWebViewNavigationType.LinkClicked {
            // Get contents of the file to load
            let fileName = request.URL?.lastPathComponent?.stringByDeletingPathExtension
            let localFilePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "html")
            var contents: NSString?
            do {
                contents = try NSString(contentsOfFile: localFilePath!, encoding: NSUTF8StringEncoding)
            } catch _ {
                contents = nil
            }
            
            // Set the base URL for the web view so we can access resources
            let baseUrl  = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
            
            // Load contents into the webview
            webView.loadHTMLString(contents as! String, baseURL: baseUrl)
            
            return false
        }
        
        // If it's the initial load
        return true
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
