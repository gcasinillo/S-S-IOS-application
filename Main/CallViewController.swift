//
//  CallViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 3/19/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CallViewController: UIViewController {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Number: UILabel!
    
    var theFirstName = ""
    var theLastName  = ""
    var theFullName  = ""
    
    var theNumber = ""
    var theNonFormattedNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  theFirstName.isEmpty && theLastName.isEmpty
        {
            self.Name.text = theFullName
            var numberString = theNonFormattedNumber
            self.Number.text = numberString.toPhoneNumber()
        }
        
        else if theFirstName.isEmpty == false && theLastName.isEmpty == true
        {
            self.Name.text = theFirstName
            self.Number.text = theNonFormattedNumber
        
        }
            
        else{
            self.Name.text = theFirstName + " " + theLastName
            self.Number.text = theNumber}
        post()
        disappear()
        
    }
    
    func post(){
        let databaseRef = FIRDatabase.database().reference()
        if  theFirstName.isEmpty && theLastName.isEmpty
        {
             let name = theFullName
             let number = theNonFormattedNumber
             let post : [String: AnyObject] = ["name" : name as AnyObject,
                                              "number": number as AnyObject]
            databaseRef.child("Phone Calls").childByAutoId().setValue(post)
        }
            
        else if theFirstName.isEmpty == false && theLastName.isEmpty == true
        {
            let name = theFirstName
            let number = theNonFormattedNumber
            let post : [String: AnyObject] = ["name" : name as AnyObject,
                                              "number": number as AnyObject]
            databaseRef.child("Phone Calls").childByAutoId().setValue(post)
            
        }
            
        else{
            let name = theFirstName + " " + theLastName
            let number = theNumber.toNumberString()
            let post : [String: AnyObject] = ["name" : name as AnyObject,
                                              "number": number as AnyObject]
            databaseRef.child("Phone Calls").childByAutoId().setValue(post)
        }
    }

    func disappear(){
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
