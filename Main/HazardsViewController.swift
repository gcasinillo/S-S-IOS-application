//
//  HazardsViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 1/19/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class HazardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myHazardArray = [HazardStruct]()
    var indexOfSubstation : String!
    var childName : String!
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        childName = "substation"+indexOfSubstation+"hazards"
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child(childName).queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let myDate = snapshotValue?["date"] as? String
            let myReport = snapshotValue?["hazardreport"] as? String
            self.myHazardArray.insert(HazardStruct(theReport: myReport, theDate: myDate), at: 0)
            self.TableView.reloadData()
        })
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myHazardArray.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let myVar : HazardStruct
        myVar = myHazardArray[indexPath.row]
        Cell.textLabel?.text = myVar.theReport
        Cell.detailTextLabel?.text = myVar.theDate
        return Cell
    }


    @IBAction func dobeButton_Pressed(_ sender: Any) {
         self.dismiss(animated: true, completion:nil);
    }


}
