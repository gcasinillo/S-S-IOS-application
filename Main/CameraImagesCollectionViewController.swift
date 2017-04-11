//
//  CameraImagesCollectionViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 4/9/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "CollectionViewCell"

class CameraImagesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    var databaseRef = FIRDatabase.database().reference()
    var CameraImageData = [CamPicInfoStruct]()
    var filename: String!
    var usersDict = NSDictionary()
    
    @IBOutlet weak var CVCloadingView: UIActivityIndicatorView!
    
    var picArray = [String]()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.CVCloadingView.startAnimating()
        databaseRef.child("Camera Data").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            let snapshotValue = snapshot.value as? NSDictionary
            let thePicsName = snapshotValue?["ImageName"] as? String
    
            self.CameraImageData.insert(CamPicInfoStruct(PicName: thePicsName), at: 0)
            self.collectionView?.reloadData()
            
            self.CVCloadingView.stopAnimating()
            
         })
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
        
        return self.CameraImageData.count
    }

    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        var myVar:CamPicInfoStruct

        myVar = self.CameraImageData[indexPath.row]
        
        let imageURL = NSURL(string: myVar.PicName)

        let imageData = NSData(contentsOf: imageURL as! URL)
        
        cell.cameraImageView.image = UIImage(data: imageData as! Data)
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    
        
        let width = (collectionView.frame.width-34)/3
        //let width = (collectionView.frame.width)/4 - 1
        return CGSize(width: width, height : width)
        
    
    
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
    return 1.0
    
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
    return 1.0
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "showCamPic", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCamPic" {
            
            let indexPaths = self.collectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destination as! CamPicViewController
            let imageURL = NSURL(string: self.CameraImageData[indexPath.row].PicName)
            let imageData = NSData(contentsOf: imageURL as! URL)
            vc.image = UIImage(data: imageData as! Data)!
            
        }
    }
}
