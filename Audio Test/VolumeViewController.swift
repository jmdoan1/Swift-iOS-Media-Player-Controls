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

        let volumeSlider = MPVolumeView(frame: self.view.layer.bounds)
        self.view.addSubview(volumeSlider)
        volumeSlider.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
