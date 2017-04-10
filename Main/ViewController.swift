//
//  ViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 1/6/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase


class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Login Screen
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        
        if(!isUserLoggedIn)
        {        self.performSegue(withIdentifier: "loginView", sender: self);}
        
    }

}





