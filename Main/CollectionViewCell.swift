//
//  CollectionViewCell.swift
//  Main
//
//  Created by Garvin Casinillo on 4/9/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cameraImageView: UIImageView!
    
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // self.makeItRound()
    }
    
    
    
    
    func makeItRound(){
        self.cameraImageView.layer.masksToBounds=true
        self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.size.width/2.0
    
    }
    
    
}
