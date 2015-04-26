//
//  ViewController.swift
//  Audio Test
//
//  Created by Justin Doan on 4/25/15.
//  Copyright (c) 2015 Justin Doan. All rights reserved.
//
//  This is a simple music controller built with Xcode 6.3.1 and Swift 1.2. Music control functions will not work in iOS Simulator, but only when built to an actual device. I believe this only controls the users actual ipod library and will not work with things such as Spotify or Pandora.
//
//  Nothing about this is particularly difficult, but I had difficulty finding all the information I needed as a new developer in one place so I thought I would put this together for anyone who might benefit.
//
//  Feel free to contact me with any questions at jmdoan1@gmail.com or on Reddit /u/AxeEffect3890
// 
//  Credit to /u/LetsCodeSomethingFun for personally helping me with some major steps here.

import UIKit
import MediaPlayer


class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    
    
    
    
    
    //Create a variable to control MPMusicPlayerController, the internal "ipod" library
    let mp = MPMusicPlayerController.systemMusicPlayer()
    
    
    
    
    // Add a notification observer for MPMusicPlayerControllerNowPlayingItemDidChangeNotification that fires a method when the track changes (to update track info label)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        mp.beginGeneratingPlaybackNotifications()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"updateNowPlayingInfo", name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: nil)
        
    }
    
    
    
    
    // Function to change labelTitle.text to current track info based on previous notification observer
    
    func updateNowPlayingInfo(){
        
        var currentTrack = MPMusicPlayerController.systemMusicPlayer().nowPlayingItem
        
        var trackName = currentTrack.valueForProperty(MPMediaItemPropertyTitle) as! String
        
        var trackArtist = currentTrack.valueForProperty(MPMediaItemPropertyArtist) as! String
        
        
        labelTitle.text = "\(trackArtist) - \(trackName)"
        
        println("\(trackArtist) - \(trackName)")
        
        
    }
    
    
    
    //Apply appropriate music controls to each button
    
    @IBAction func buttonPlay(sender: AnyObject) {
        
        mp.play()
        
        println("play")
        
    }
    
    @IBAction func buttonPause(sender: AnyObject) {
        
        mp.pause()
        
        println("pause")
        
    }
    
    @IBAction func buttonBeginning(sender: AnyObject) {
        
        mp.skipToBeginning()
        
        println("beggining")
        
    }
    
    @IBAction func buttonPrevious(sender: AnyObject) {
        
        mp.skipToPreviousItem()
        
        println("previous")
        
    }
    
    @IBAction func buttonNext(sender: AnyObject) {
        
        mp.skipToNextItem()
    
        println("next")
        
    }
//There are other controls available, such as mp.stop(), mp.beginSeekingForward(), mp.endSeeking(), etc. Feel free to play around
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //if no music is detected when app is opened, we don't want labelTitle to show up. The notification function will override this when applicable
        
        labelTitle.text = " "
        
        
        
        // set up volume controller under labelTitle -- As a new developer, I don't fully understand this, it was just a matter of finding the right forum to copy and paste from. The frame is made to look good when built to an iPhone 6
        var wrapperView = UIView(frame: CGRectMake(55, 290, 260, 20))
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(wrapperView)
        
        var volumeView = MPVolumeView(frame: wrapperView.bounds)
        wrapperView.addSubview(volumeView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

