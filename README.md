# Swift-iOS-Media-Player-Controls

This is a simple music controller built with Xcode 6.3.1 and Swift 1.2. (Updated Nov. 13, 2015 for Xcode 7 and swift 2) Music control functions will not work in iOS Simulator, but only when built to an actual device that has a music library. I believe this only controls the users actual ipod library and will not work with things such as Spotify or Pandora.

Nothing about this is particularly difficult, but I had difficulty finding all the information I needed as a new developer in one place so I thought I would put this together for anyone who might benefit.

Feel free to contact me with any questions at jmdoan1@gmail.com or on Reddit /u/AxeEffect3890

1. WHAT IT HAS:

  A. Buttons: 
    1. Play
    2. Pause
    3. Previous [song]
    4. Beggining [of song]
    5. Next [song]
    6. Pick [somg(s) or playlist(s)]

  B. Labels: 
    1. Song artist and title
    2. Song length
    3. Elapsed time (constantly updating)
    4. Remaining time (constantly updating)

  C. Sliders: 
    1. Elapsed time slider
      a. Added through story board
      b. Constantly updates as song progresses
      c. Sliding it changes location in song
    2. Volume slider
      a. Added programmatically
      b. Shows device volume and updates when volume buttons are pressed
      c. Sliding it changes device volume
      
2. WHAT IT DOESN'T HAVE

  A. Shuffle or repeat settings
