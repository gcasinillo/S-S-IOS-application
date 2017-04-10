//
//  CameraImagesCollectionViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 4/9/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase



class CameraImagesCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "CollectionViewCell"
    
    var database: FIRDatabase!
    var storage: FIRStorage!
    var CameraImageData = [CamPicInfoStruct]()
    var filename: String!
    
    
    
    var picArray = [String]()
  


    override func viewDidLoad() {
        super.viewDidLoad()


        let databaseRef = FIRDatabase.database().reference()
        
        
        databaseRef.child("Camera Data").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let thePicsName = snapshotValue?["ImageName"] as? String
            
            
            let storageRef = FIRStorage.storage().reference().child("Camera/" + thePicsName!);
            let islandRef = storageRef
          //  self.filename = ("/Camera/" + thePicsName!)
           // let storage = FIRStorage.storage().reference(withPath: self.filename)
            
            islandRef.downloadURL { url, error in
                if error != nil {
                    print("You got an error")
                } else {
                    let myString = url?.absoluteString

                    
                    self.picArray.append(myString!)
                    print(self.picArray)
                    self.collectionView?.reloadData()
                    print("HELLO YOU are here")
                }
                
                print(self.picArray)
            }
         })
        
    
        
        
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        print("this is the count: ", self.picArray.count)
        return self.picArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let imageURL = NSURL(string: self.picArray[indexPath.row])
        print(self.picArray)
        
     
        let imageData = NSData(contentsOf: imageURL! as URL)
        
        cell.cameraImageView.image = UIImage(data: imageData as! Data)
    
        return cell
    }



}
