//
//  VolumeViewController.swift
//  Audio Test
//
//  Created by Justin Doan on 4/23/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit
import MediaPlayer

class VolumeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Create view that holds volume slider with its frame made from the boundaries of the controller view
        let volumeSlider = MPVolumeView(frame: self.view.layer.bounds)
        
        //Add the new view to the view controller
        self.view.addSubview(volumeSlider)
        
        //To ensure the volume slider stays within the bounds of the view
        volumeSlider.clipsToBounds = true
        
    }

}
