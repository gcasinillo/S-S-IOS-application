//
//  CamPicViewController.swift
//  Main
//
//  Created by Garvin Casinillo on 4/10/17.
//  Copyright © 2017 Garvin Casinillo. All rights reserved.
//

import UIKit

class CamPicViewController: UIViewController , UIScrollViewDelegate{

    @IBOutlet weak var camPicture: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(gestureRecognizer:)))
        tapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapRecognizer)

        
        self.camPicture.image = self.image

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func onDoubleTap(gestureRecognizer: UITapGestureRecognizer) {
        let scale = min(scrollView.zoomScale * 2, scrollView.maximumZoomScale)
        if scale != scrollView.zoomScale {
            let point = gestureRecognizer.location(in: camPicture)
            let scrollSize = scrollView.frame.size
            let size = CGSize(width: scrollSize.width / scale,
                              height: scrollSize.height / scale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            scrollView.zoom(to:CGRect(origin: origin, size: size), animated: true)
        }
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.camPicture
    }
    
    
    
    
    
    

}
