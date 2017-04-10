//
//  SubstationImageViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 1/23/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class SubstationImageViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ImageViewer: UIImageView!
    var imageString : String!
    var SubStatName : String!
    var filename : String!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filename = ("/" + SubStatName + "/" + imageString)
        let storage = FIRStorage.storage().reference(withPath: filename)
        let tempImageRef = storage
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0

        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(gestureRecognizer:)))
        tapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapRecognizer)
        
        
        tempImageRef.data(withMaxSize: 10 * 1000 * 1000){ (data, error) in
    
        if error == nil{
            self.ImageViewer.image = UIImage(data: data!)
        
            }else
            {
                print("Error!!!")
            }
        }
    }
    
    func onDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
        let scale = min(scrollView.zoomScale * 2, scrollView.maximumZoomScale)
        if scale != scrollView.zoomScale {
            let point = gestureRecognizer.location(in: ImageViewer)
            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / scale,
                              height: scrollSize.height / scale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        }
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.ImageViewer
    }
}
