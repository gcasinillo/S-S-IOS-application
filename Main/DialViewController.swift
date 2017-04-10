//
//  DialViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 3/22/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit

class DialViewController: UIViewController {

    var phoneNumberDialed: String!
    var phoneNumberName: String!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var backSpace: UIButton!
    
    @IBAction func numbers(_ sender: UIButton) {
        if (phoneNumber.text! as NSString).length < 14{
            backSpace.isHidden = false
 
            if sender.tag == 11
            {
               phoneNumber.text! = String(phoneNumber.text!.characters.dropLast())
               if phoneNumber.text! == ""{
                backSpace.isHidden = true
                }
            }
            else{
                phoneNumber.text =  phoneNumber.text! + String(sender.tag-1)
                phoneNumber.text = phoneNumber.text?.toFormattedPhoneNumber()
                }
            }

            else{
                if sender.tag == 11{
                    phoneNumber.text! = String(phoneNumber.text!.characters.dropLast())
                }
            else{
                    phoneNumber.text =  phoneNumber.text! + String(sender.tag-1)
                    phoneNumber.text = phoneNumber.text?.toNumberString()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backSpace.isHidden = true
    }

    @IBAction func callButtonTapped(_ sender: UIButton) {
        
 
       phoneNumberDialed = phoneNumber.text
        phoneNumberName = phoneNumber.text
        phoneNumber.text = ""
        if NSString(string: phoneNumberDialed).contains("-") {
            phoneNumberDialed = "1"+phoneNumberDialed.toNumberString()
        }
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CallViewController {
            destination.theFirstName = phoneNumberName
            destination.theNonFormattedNumber = " " + phoneNumberDialed
        }
    }
        
override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
  if identifier == "callSegue" {
            if phoneNumberName == ""{
                return false
            }
                
            else {
                return true
            }
        }
    return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
