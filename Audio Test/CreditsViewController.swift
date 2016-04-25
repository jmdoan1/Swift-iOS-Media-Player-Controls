//
//  CreditsViewController.swift
//  Audio Test
//
//  Created by Justin Doan on 4/24/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url  = NSURL(string: "http://justindoan.com/muhFace.png"),
            data = NSData(contentsOfURL: url)
        {
            image.image = UIImage(data: data)
        }
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
