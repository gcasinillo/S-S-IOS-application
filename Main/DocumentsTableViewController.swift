//
//  DocumentsTableViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 1/29/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit

class DocumentsTableViewController: UITableViewController {
    
    var substationNameString: String!
    var myDocArray = [String]()
    var myDocString: String!
    var docStructArray = [DocumentStruct]()
    var mySecondDocArray = [String]()
    
    
    var identities = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      let myDocArray = myDocString.characters.split{$0 == ","}.map(String.init)


        for item in myDocArray{
            let myItem = item.trimmingCharacters(in: .whitespaces)
            self.docStructArray.insert(DocumentStruct(subDocument: myItem, subDocumentLink: myItem), at: 0)
            self.docStructArray.sort(by: {$0.subDocument < $1.subDocument})
        }
        mySecondDocArray = myDocArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySecondDocArray.count
    }

    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let myVar : DocumentStruct
        myVar = docStructArray[indexPath.row]

        if let dotRange = myVar.subDocument.range(of: ".") {
            myVar.subDocument.removeSubrange(dotRange.lowerBound..<myVar.subDocument.endIndex)
            Cell.textLabel?.text = myVar.subDocument
            Cell.textLabel?.font = UIFont(name:"Helvetica", size:20)
        }
        return Cell
    }
    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVar: DocumentStruct
        myVar = docStructArray[indexPath.row]
        let delimiter = "."
        var token = (myVar.subDocumentLink).components(separatedBy:delimiter)
        
        if token[1] ==  "jpg"  || token[1] ==  "jpeg"   || token[1] ==  "gif" || token[1] ==  "png"{
           performSegue(withIdentifier: "imageSegue", sender: indexPath)
        }
        
        
        else if token[1] ==  "pdf" || token[1] ==  "docx"   || token[1] ==  "txt"  || token[1] ==  "rtf"  || token[1] ==  "pptx" || token[1] ==  "ppt"{
             performSegue(withIdentifier: "theDocumentSegue", sender: indexPath)
        }

    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageSegue" {
            if let destination = segue.destination as? SubstationImageViewController{
                destination.SubStatName = substationNameString
                let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
                let myVar: DocumentStruct
                myVar = docStructArray[indexPath.row]
                destination.imageString = myVar.subDocumentLink
            
        
            }
        }

            if segue.identifier == "theDocumentSegue" {
                if let destination = segue.destination as? SubstationDocumentViewController{
                    destination.SubStatName = substationNameString
                    let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
                    let myVar: DocumentStruct
                    myVar = docStructArray[indexPath.row]
                    destination.filename = myVar.subDocumentLink

                }
        }
    
    
    }
    
    
    



}
