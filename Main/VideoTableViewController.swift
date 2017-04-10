//
//  VideoTableViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 2/4/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import AVKit
import AVFoundation
import MediaPlayer

class VideoTableViewController: UITableViewController, UISearchResultsUpdating {
    @IBOutlet weak var searchBar: UISearchBar!
    var searchController:UISearchController!
    var videoInfoArrayFiltered = [VideoInfoStruct]()
    var videoInfo = [VideoInfoStruct]()
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        let databaseRef = FIRDatabase.database().reference()
        
        
        databaseRef.child("Tutorial Videos").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue?["Name"] as? String
            let link = snapshotValue?["Link"] as? String
            let description = snapshotValue?["description"] as? String
            
            self.videoInfo.insert(VideoInfoStruct(videoName: name, videoLink: link, videoDescription: description), at: 0)
            self.videoInfo.sort(by: {$0.videoName < $1.videoName})
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


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (searchController.isActive)
        {
            return self.videoInfoArrayFiltered.count
        }
        else{
        
        
            return videoInfo.count}
    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var myVar : VideoInfoStruct
        if (searchController.isActive)
        {
            myVar = self.videoInfoArrayFiltered[indexPath.row]
            let videoTitle =  myVar.videoName
            let label = cell?.viewWithTag(2) as! UILabel
            label.text = videoTitle
            let videoThumbnailUrlString = "https://i1.ytimg.com/vi/" + myVar.videoLink + "/maxresdefault.jpg"
            let videoThumbnailUrl = URL(string: videoThumbnailUrlString)
            if videoThumbnailUrl != nil{
                let request = URLRequest(url: videoThumbnailUrl!)
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                    
                    DispatchQueue.main.async(execute: {()-> Void in
                        let imageView = cell?.viewWithTag(1) as! UIImageView
                        imageView.image = UIImage(data: data!)
                    })
                })
                dataTask.resume()
            }
            return cell!
        }
        else{
            myVar = self.videoInfo[indexPath.row]
            let videoTitle =  myVar.videoName
            let label = cell?.viewWithTag(2) as! UILabel
            label.text = videoTitle
            let videoThumbnailUrlString = "https://i1.ytimg.com/vi/" + myVar.videoLink + "/maxresdefault.jpg"
            let videoThumbnailUrl = URL(string: videoThumbnailUrlString)
            if videoThumbnailUrl != nil{
                let request = URLRequest(url: videoThumbnailUrl!)
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                    
                    DispatchQueue.main.async(execute: {()-> Void in
                        let imageView = cell?.viewWithTag(1) as! UIImageView
                        imageView.image = UIImage(data: data!)
                    })
                })
                dataTask.resume()
            }
            return cell!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SendVideoSegue" {
            if let destination = segue.destination as? VideoDetailViewController {

                let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
                let myVar: VideoInfoStruct
                
                if (searchController.isActive)
                {
                    myVar = videoInfoArrayFiltered[indexPath.row]
                    destination.myVideoTitle = myVar.videoName
                    destination.myVideoDescription = myVar.videoDescription
                    destination.myVideoLink =  myVar.videoLink
                }else{
                myVar = videoInfo[indexPath.row]
                destination.myVideoTitle = myVar.videoName
                destination.myVideoDescription = myVar.videoDescription
                destination.myVideoLink =  myVar.videoLink}
            }
        }
    }
    

    
    //Search
    func filterContentForSearchText(searchText: String, scope: String = "Title")
    {
        self.videoInfoArrayFiltered = self.videoInfo.filter({( friend : VideoInfoStruct) -> Bool in
            let categoryMatch = (scope == "Title")
            let nameMatch = friend.videoName.range(of: searchText)
            return categoryMatch && (nameMatch != nil)
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
