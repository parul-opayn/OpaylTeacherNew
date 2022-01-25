//
//  MusicPlayerView.swift
//  IletsLearning
//
//  Created by OPAYN on 08/11/21.
//

import Foundation
import AVFoundation
import UIKit

class MusicPlayerView: UIView {
    
    //MARK: - Variables for AVPlayer
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var secondsRemaining = 0
    fileprivate let seekDuration: Float64 = 10
    var playerTotalTime:UILabel!
    var playerCurrentTime:UILabel!
    var playerSlider:UISlider!
    
    // Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    deinit {
        self.player?.pause()
        self.player = nil
        self.playerItem = nil
    }
    
    //MARK: - Custom Methods
    
    func setUpViews(){
        
        playerCurrentTime = UILabel()
        playerTotalTime = UILabel()
        playerSlider = UISlider()
        
        playerSlider.tintColor = UIColor(named: "AppMainPink")
        playerCurrentTime.font = UIFont(name: "Asap-Medium", size: 12)
        playerTotalTime.font = UIFont(name: "Asap-Medium", size: 12)
        
        let stackView = UIStackView(arrangedSubviews: [playerCurrentTime, playerSlider, playerTotalTime])
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.axis = .horizontal
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
        ])
    }
    
    
    func playAudio(withUrl url:String){
        
        //Step:1 Set the URL
        
        let url = URL(string: url)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        playerSlider.minimumValue = 0
        
        //Step:2 To get overall duration
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        playerTotalTime.text = self.stringFromTimeInterval(interval: seconds)
        
        //Step:3 To get the current duration of the audio
        
        let currentDuration : CMTime = playerItem.currentTime()
        let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)
        playerCurrentTime.text = self.stringFromTimeInterval(interval: currentSeconds)
        
        //Step:4 Set the playerSlider maximumValue with the overAllDuration
        
        playerSlider.maximumValue = Float(seconds)
        playerSlider.isContinuous = true
        
        //Step:5 Play Audio
        
        player!.play()
        
        //Step:6 If you want to change the progress value use the following code in view didLoad
        
        playerSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        
        //Step:7 add observer to check player has completed playing audio not if complete change the button state
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        
        //Step:8 Call the addPeriodicTimeObserver to continuously change the value of the current time and progress value and to keep track of player is playing or buffering if player is buffering hide the the button and show the loader else wise versa.
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            
            if self.player!.currentItem?.status == .readyToPlay {
                
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                self.playerSlider.value = Float ( time );
                self.playerCurrentTime.text = self.stringFromTimeInterval(interval: time)
                
            }
            
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            
            if playbackLikelyToKeepUp == false{
                
                print("IsBuffering")
                // self.ButtonPlay.isHidden = true
                // self.loadingView.isHidden = false
            }
            
            else {
                
                //stop the activity indicator
                print("Buffering completed")
                //self.ButtonPlay.isHidden = false
                // self.loadingView.isHidden = true
                
            }
        }
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func playAudio(){
        if player!.rate == 0 {
            player?.play()
        }
    }
    
    func pauseAudio(){
        player?.pause()
    }
    
    //MARK: - Objc Methods
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player!.seek(to: targetTime)
        
        if player!.rate == 0 {
            player?.play()
        }
        
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        print("Audio Finished")
    }
    
}
