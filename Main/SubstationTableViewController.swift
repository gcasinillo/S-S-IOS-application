//
//  SubstationTableViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 1/10/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SubstationTableViewController: UITableViewController, UISearchResultsUpdating{
    
    
    
    

    var substationData = [SubstationStruct]()
    var filteredSubstationData = [SubstationStruct]()
    var searchController:UISearchController!
    var ref: FIRDatabaseReference!
    var refresher: UIRefreshControl!


    @IBOutlet weak var searchBar: UISearchBar!
  
    
    override func viewDidLoad() {
        
        
       // let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //appDelegate.shouldRotate = true // or false to disable rotation
        
        
        
        
        super.viewDidLoad()
        let databaseRef = FIRDatabase.database().reference()
        
        
        databaseRef.child("Substation Data").queryOrderedByKey().observe(.childAdded, with: {
        snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let title = snapshotValue?["Name"] as? String
            let message = snapshotValue?["Address"] as? String
            let long = snapshotValue?["longitude"] as? Double
            let lat = snapshotValue?["latitude"] as? Double
            let docs = snapshotValue?["documents"] as? String
            let theIndex = snapshot.key
            
            self.substationData.insert(SubstationStruct(SSName: title, SSaddress: message, longtitude : long, latitude: lat, theDocuments: docs, index:  theIndex), at: 0)
            self.substationData.sort(by: {$0.SSName < $1.SSName})
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive)
        {
        return self.filteredSubstationData.count
        }
        else{
            return substationData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        var myVar : SubstationStruct
        
        if (searchController.isActive)
        {
            myVar = self.filteredSubstationData[indexPath.row]
            
        }
        else{
            myVar = self.substationData[indexPath.row]
        }
        
        cell?.textLabel?.text = myVar.SSName
        cell!.detailTextLabel?.text = myVar.SSaddress
        
        return cell!
    }
    
    
//Search
    func filterContentForSearchText(searchText: String, scope: String = "Title")
    {
        self.filteredSubstationData = self.substationData.filter({( friend : SubstationStruct) -> Bool in
            let categoryMatch = (scope == "Title")
            
            let nameMatch = friend.SSName.range(of: searchText)
            
            let addressMatch2 = friend.SSaddress.range(of: searchText)
            
            
            return categoryMatch && (nameMatch != nil) || (addressMatch2 != nil)
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
    
    
    
    //Segue
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SendDataSegue" {
            if let destination = segue.destination as? SubstationDetailedViewController {
                
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRow(at: path!)
                destination.titleString = (cell?.textLabel?.text!)!
                destination.addressString = (cell?.detailTextLabel?.text!)!
                
                let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
                let myVar: SubstationStruct
                
                
                if (searchController.isActive){
                myVar = filteredSubstationData[indexPath.row]
                
                destination.desLatitude = myVar.latitude
                destination.desLongtitude = myVar.longtitude
                destination.substationIndex =  myVar.index
                    destination.documentStringValue = myVar.theDocuments}
                
                else{
                    myVar = substationData[indexPath.row]
                    destination.desLatitude = myVar.latitude
                    destination.desLongtitude = myVar.longtitude
                    destination.substationIndex =  myVar.index
                    destination.documentStringValue = myVar.theDocuments
                
                }
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        if tableView.cellForRow(at: indexPath as IndexPath) != nil {
            self.performSegue(withIdentifier: "SendDataSegue", sender: self)
        }
    }
    
}

