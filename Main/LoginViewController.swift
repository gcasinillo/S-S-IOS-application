//
//  LoginViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 1/9/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Username: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    @IBAction func login(_ sender: Any) {
        
        if self.Username.text == "" || self.Password.text == ""
        {
            let alertController = UIAlertController(title: "Error!", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.signIn(withEmail: Username.text!, password: Password.text!, completion: {
                user, error in
                if error == nil{
                   //User is logged in
                    UserDefaults.standard.set(true,forKey:"isUserLoggedIn");
                    UserDefaults.standard.synchronize();
                    self.dismiss(animated: true, completion:nil);
                }
                else{
                    let alertController = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                
            })
        }
        
    }
}
