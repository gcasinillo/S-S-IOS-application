//
//  RecentCallsTableViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 3/21/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RecentCallsTableViewController: UITableViewController {
    var recentCall = [RecentCallStruct]()
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("Phone Calls").queryLimited(toLast: 15).observe(.childAdded, with: {
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let Name = snapshotValue?["name"] as? String
            let Number = snapshotValue?["number"] as? String
            
            self.recentCall.insert(RecentCallStruct(contactName: Name, contactNumber: Number), at: 0)
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentCall.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var myVar : RecentCallStruct
        myVar = self.recentCall[indexPath.row]
        cell?.textLabel?.text = myVar.contactName
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "callSegue" {
            if let destination = segue.destination as? CallViewController {
                let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
                let myVar: RecentCallStruct
                myVar = recentCall[indexPath.row]
                destination.theFullName = myVar.contactName
                destination.theNonFormattedNumber =  myVar.contactNumber
            }
        }
    }
    
}
