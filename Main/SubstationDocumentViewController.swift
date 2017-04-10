//
//  SubstationDocumentViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 4/6/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//
import WebKit
import UIKit
import Firebase
import FirebaseStorage

class SubstationDocumentViewController: UIViewController {
    //var imageString : String!
    var SubStatName : String!
    var filename : String!
    
    @IBOutlet weak var webView: UIWebView!

   // private var projectURL: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        let storageRef = FIRStorage.storage().reference().child(SubStatName + "/" + filename);
        let islandRef = storageRef
    
        islandRef.downloadURL { url, error in
            if error != nil {
                print("You got an error")
            } else {
                let myString = url?.absoluteString
                let targetURL = URL(string:myString!)!
                let request = URLRequest(url: targetURL)
                self.webView.loadRequest(request)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}



