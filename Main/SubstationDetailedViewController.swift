//
//  SubstationDetailedViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 1/12/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import MapKit




class SubstationDetailedViewController: UIViewController {
    //Hazards
    var substationIndex: String!
    //Documents
    var documentStringValue: String!
    var documentArrayString = [String]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var titleString = ""
    var addressString = ""
    var desLongtitude: Double = 0.0
    var desLatitude: Double = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Prints the labels
        self.titleLabel.text = titleString + " Substation"
        self.addressLabel.text = addressString

        
        //Creates the span of map view
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(desLatitude, desLongtitude)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 2000, 2000), animated: true)
        
        //Creates the annotation
        let myAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = location
        myAnnotation.title = titleString + " Substation"
        myAnnotation.subtitle = addressString
        mapView.addAnnotation(myAnnotation)
        mapView.selectAnnotation(myAnnotation, animated: true)
 
        
    }
   
    
    @IBAction func dirButtonPressed(_ sender: Any) {
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(desLatitude, desLongtitude)
        let myPlaceMark = MKPlacemark(coordinate: location, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: myPlaceMark)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
          mapItem.openInMaps(launchOptions: launchOptions)
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hazardSegue" {
        let hazardViewCont = segue.destination as! HazardsViewController
        hazardViewCont.indexOfSubstation = substationIndex
        }
        
        
        
        
        
        
        if segue.identifier == "tableImageSegue"{
            let documentTableCont = segue.destination as! DocumentsTableViewController
            documentTableCont.myDocString = documentStringValue
            documentTableCont.substationNameString = titleString
        }
    }
    
 
    
}
