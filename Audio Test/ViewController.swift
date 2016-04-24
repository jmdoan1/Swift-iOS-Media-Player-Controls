//
//  ViewController.swift
//  Audio Test
//
//  Created by Justin Doan on 4/25/15.
//  Copyright (c) 2015 Justin Doan. All rights reserved.
//
//  This is a simple music controller built with Xcode 6.3.1 and Swift 1.2. (Updated Nov. 13, 2015 for Xcode 7 and swift 2) Music control functions will not work in iOS Simulator, but only when built to an actual device that has a music library. I believe this only controls the users actual ipod library and will not work with things such as Spotify or Pandora.
//
//  Nothing about this is particularly difficult, but I had difficulty finding all the information I needed as a new developer in one place so I thought I would put this together for anyone who might benefit.
//
//  Feel free to contact me with any questions at jmdoan1@gmail.com or on Reddit /u/AxeEffect3890

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    //Create a variable to control MPMusicPlayerController, the internal "ipod" library
    let mp = MPMusicPlayerController.systemMusicPlayer()
    
    var timer = NSTimer()
    
    var mediapicker1: MPMediaPickerController?
    
    @IBOutlet var imageAlbum: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelElapsed: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRemaining: UILabel!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calls timer and related functions when view is first loaded to avoiding waiting for playback change notificaitons
        mp.prepareToPlay()
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: #selector(ViewController.timerFired(_:)), userInfo: nil, repeats: true)
        self.timer.tolerance = 0.1
        
        let mediaPicker: MPMediaPickerController = MPMediaPickerController.self(mediaTypes:MPMediaType.Music)
        mediaPicker.allowsPickingMultipleItems = false
        mediapicker1 = mediaPicker
        mediaPicker.delegate = self
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // Add a notification observer for MPMusicPlayerControllerNowPlayingItemDidChangeNotification that fires a method when the track changes (to update track info label)
        mp.beginGeneratingPlaybackNotifications()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.updateNowPlayingInfo), name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: nil)
        
    }
    
    // Create function to change labels to current track info based on previous notification observer
    func updateNowPlayingInfo(){
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: #selector(ViewController.timerFired(_:)), userInfo: nil, repeats: true)
        self.timer.tolerance = 0.1
        
    }
    
    //Function to pull track info and update labels
    func timerFired(_:AnyObject) {
        
        if let currentTrack = MPMusicPlayerController.systemMusicPlayer().nowPlayingItem {
            
            //pull artist and title for current track and show in lebalTitle
            let trackName = currentTrack.title!
            
            let trackArtist = currentTrack.artist!
            
            labelTitle.text = "\(trackArtist) - \(trackName)"
            
            //set image to Album Artwork
            imageAlbum.image = currentTrack.artwork?.imageWithSize(imageAlbum.bounds.size)
            
            //Pull length of current track in seconds
            //let trackDuration = currentTrack.valueForProperty(MPMediaItemPropertyPlaybackDuration) as! Int
            let trackDuration = currentTrack.playbackDuration
            
            //Convert length in seconds to length in minutes as an Int. Ex. 245 second song is 4.08333 minutes (4:05), this results in 4
            let trackDurationMinutes = Int(trackDuration / 60)
            
            //Find the remainder from the previous equation. 245 / 60 is 4 with a remainder of 5. This results in 5
            let trackDurationSeconds = Int(trackDuration % 60)
            
            //Create the lable for the length of the song. BUT a 4 minute long song with a 5 second remainder would show as "4:5" so..
            if trackDurationSeconds < 10 {
                
                //add a 0 if the number of seconds is less than 10
                labelDuration.text = "Length: \(trackDurationMinutes):0\(trackDurationSeconds)"
                
            } else {
                
                //if more than 10, display as is
                labelDuration.text = "Length: \(trackDurationMinutes):\(trackDurationSeconds)"
            }
            
            //Find elapsed time by pulling currentPlaybackTime
            let trackElapsed = mp.currentPlaybackTime
            
            //Repeat same steps to display the elapsed time as we did with the duration
            let trackElapsedMinutes = Int(trackElapsed / 60)
            
            let trackElapsedSeconds = Int(trackElapsed % 60)
            
            if trackElapsedSeconds < 10 {
                
                labelElapsed.text = "Elapsed: \(trackElapsedMinutes):0\(trackElapsedSeconds)"
                
            } else {
                
                labelElapsed.text = "Elapsed: \(trackElapsedMinutes):\(trackElapsedSeconds)"
                
            }
            
            //Find remaining time by subtraction the elapsed time from the duration
            let trackRemaining = Int(trackDuration) - Int(trackElapsed)
            
            //Repeat same steps to display remaining time
            let trackRemainingMinutes = trackRemaining / 60
            
            let trackRemainingSeconds = trackRemaining % 60
            
            if trackRemainingSeconds < 10 {
                labelRemaining.text = "Remaining: \(trackRemainingMinutes):0\(trackRemainingSeconds)"
            } else {
                labelRemaining.text = "Remaining: \(trackRemainingMinutes):\(trackRemainingSeconds)"
            }
            
            //set maximum value of the slider (established below)
            sliderTime.maximumValue = Float(trackDuration)
            
            //changes slider to number of seconds that have elapsed
            sliderTime.value = Float(trackElapsed)
            
        }
        
    }
    
    @IBOutlet weak var sliderTime: UISlider!
    
    //Function to make adjusting the slider move through the song. It's kind of clunky but idk how to make it un-clunky
    @IBAction func sliderTimeChanged(sender: AnyObject) {
        
        //let trackElapsed = Float(mp.currentPlaybakTime)
        //print(trackElapsed);
        //^commented out because it creates a constant flow of 0's unless you are moving the slider
        
        mp.currentPlaybackTime = NSTimeInterval(sliderTime.value)
        
    }
    
    
    
    
    //Button functions -- I'm pretty sure these are self explanatory enough
    @IBAction func buttonPlay(sender: AnyObject) {
        
        print("Play")
        mp.play()
        
    }
    
    @IBAction func buttonPause(sender: AnyObject) {
        
        print("Pause")
        
        mp.pause()
        
    }
    
    @IBAction func buttonPrevious(sender: AnyObject) {
        
        print("Previous")
        
        mp.skipToPreviousItem()
        
    }
    
    @IBAction func buttonBeginning(sender: AnyObject) {
        
        print("Beginning")
        
        mp.skipToBeginning()
        
    }
    
    @IBAction func buttonNext(sender: AnyObject) {
        
        print("Next")
        
        mp.skipToNextItem()
        
    }
    
    @IBAction func buttonPick(sender: AnyObject) {
        self.presentViewController(mediapicker1!, animated: true, completion: nil)
    }
    
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("you picked: \(mediaItemCollection)")
        let selectedSong = mediaItemCollection
        
        mp.setQueueWithItemCollection(selectedSong)
        mp.play()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

