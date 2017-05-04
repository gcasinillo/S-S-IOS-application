//
//  PhoneTableViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 3/19/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
//Contact Information


class PhoneTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchController:UISearchController!
    var phoneInfo = [PhoneInfoStruct]()
    var phoneInfoFiltered = [PhoneInfoStruct]()
    
    
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseRef = FIRDatabase.database().reference()
        
        
        databaseRef.child("Contact Information").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let FirstName = snapshotValue?["First"] as? String
            let LastName = snapshotValue?["Last"] as? String
            let number = snapshotValue?["Number"] as? String
            
            self.phoneInfo.insert(PhoneInfoStruct(contactFirstName: FirstName, contactLastName: LastName, contactNumber: number), at: 0)
            self.phoneInfo.sort(by: {$0.contactLastName < $1.contactLastName})
            self.tableView.reloadData()
        })
        
        //Search Bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false

    }

    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText: searchText!)
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive)
        {
            return self.phoneInfoFiltered.count
        }
        else{
            return phoneInfo.count}
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var myVar : PhoneInfoStruct
        if (searchController.isActive)
        {
            myVar = self.phoneInfoFiltered[indexPath.row]
            
        }
        else{
            myVar = self.phoneInfo[indexPath.row]
        }
        
        
        cell?.textLabel?.text = myVar.contactFirstName + " " + myVar.contactLastName
        cell!.detailTextLabel?.text = myVar.contactNumber

        return cell!
    }
 

//  
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "callSegue" {
//            if let destination = segue.destination as? CallViewController {
//                let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
//                let myVar: PhoneInfoStruct
//                
//                if (searchController.isActive)
//                {
//                    myVar = phoneInfoFiltered[indexPath.row]
//                    destination.theFirstName = myVar.contactFirstName
//                    destination.theLastName = myVar.contactLastName
//                    destination.theNumber =  myVar.contactNumber
//                }
//                else{
//                    myVar = phoneInfo[indexPath.row]
//                    destination.theFirstName = myVar.contactFirstName
//                    destination.theLastName = myVar.contactLastName
//                    destination.theNumber =  myVar.contactNumber
//                }
//            }
//        }
//    }
    
    //Search
    func filterContentForSearchText(searchText: String, scope: String = "Title")
    {
        self.phoneInfoFiltered = self.phoneInfo.filter({( friend : PhoneInfoStruct) -> Bool in
            let categoryMatch = (scope == "Title")
            let firstNameMatch = friend.contactFirstName.range(of: searchText)
            let lastNameMatch = friend.contactLastName.range(of: searchText)
            let numberMatch = friend.contactNumber.range(of: searchText)
            return categoryMatch && (firstNameMatch != nil) || (lastNameMatch != nil) || (numberMatch != nil)
        })
    }
    
    
    func searchDisplayController(_ controller: UISearchController, shouldReloadTableForSearch searchString: String?) -> Bool
    {
        self.filterContentForSearchText(searchText: searchString!, scope: "Title")
        return true
    }
    
    
    func searchDisplayController(_ controller: UISearchController, shouldReloadTableForSearchScope searchOption: Int) -> Bool
    {
        self.filterContentForSearchText(searchText: self.searchController!.searchBar.text!, scope: "Title")
        return true
        
    }

}
