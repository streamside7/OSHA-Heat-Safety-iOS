//
//  PrecautionsController.swift
//  Heat Tool
//
//  Created by E J Kalafarski on 2/17/15.
//  Code is in the public domain
//

import UIKit

class PrecautionsController: GAITrackedViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var precautionLevel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View name for Google Analytics
        self.screenName = "Precautions Screen"

        // Do any additional setup after loading the view.
        webView.delegate = self
        
        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource(precautionLevel, ofType: "html")!)
        
        let request = NSURLRequest(URL: url)

        webView.loadRequest(request)
        
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
