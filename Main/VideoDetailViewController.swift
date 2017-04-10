//
//  VideoDetailViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 2/5/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit

class VideoDetailViewController: UIViewController {

  //  @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var myVideoTitle = ""
    var myVideoDescription  = ""
    var myVideoLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.mediaPlaybackRequiresUserAction = false;
        
    
    self.titleLabel.text = myVideoTitle
    self.descriptionLabel.text = myVideoDescription
        
        let width = self.view.frame.size.width
        let height = (width/320)*180
        
        let videoEmbedString = "<iframe width=\"" + String(describing: width) + "\" height=\""+String(describing: height)+"\" src=\"https://www.youtube.com/embed/" + myVideoLink + "\" frameborder=\"0\" allowfullscreen></iframe>"
        
        self.webView.loadHTMLString(videoEmbedString, baseURL: nil)
    }

    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
