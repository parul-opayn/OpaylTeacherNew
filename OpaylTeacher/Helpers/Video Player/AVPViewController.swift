//
//  AVPViewController.swift
//  Chato
//
//  Created by promatics on 1/20/21.
//  Copyright © 2021 Promatics. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class AvpVideoPlayer: UIView {
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var playerController = AVPlayerViewController()
    var isLoop: Bool = false
    var isPlayed = false
    var isPlayerFullScreen = false
    
    var observer: NSKeyValueObservation?

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    deinit {
//
////        self.removeObserver()
////        self.player?.replaceCurrentItem(with: nil)
////        player = nil
////        playerLayer = nil
////        playerController.player = nil
//        self.observer?.invalidate()
//         self.observer = nil
//    }
    
    func configure(url: String, fullscreen: Bool) {
       
        if let videoURL = URL(string: url) {
            
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = bounds
            playerController.delegate = self
            //playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
            
            if let playerLayer = self.playerLayer {
                layer.addSublayer(playerLayer)
            }
            if fullscreen{
                playerController.videoGravity = .resizeAspectFill
            }else{
                playerController.videoGravity = .resizeAspect
            }
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                } catch {
                    print("AVAudioSessionCategoryPlayback not work")
                }
            playerController.showsPlaybackControls = true
            
            NotificationCenter.default.addObserver(self, selector: #selector(reachTheEndOfTheVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
//            player?.addObserver(self, forKeyPath: "rate", options: [], context: nil)
            //playerController.addObserver(self, forKeyPath: #keyPath(AVPlayerViewController.videoBounds), options: [.old, .new], context: nil)
            //playerController.addObserver(self, forKeyPath: #keyPath(AVPlayerViewController.videoBounds), options: [.old, .new], context: nil)
        }
    }
    
    func observeVideoPlayer(){
        
        if let _ = player{
         
            self.observer = player?.observe(\.rate, options:  [.new, .old], changeHandler: { (player, change) in
                
                if player.rate == 1  {
                      print("Playing")
                     self.isPlayed = true
                    NotificationCenter.default.post(name: .currentPlayerRate, object: nil, userInfo: ["rate":1])
                  }
                else{
                       print("Stop")
                      self.isPlayed = false
                      NotificationCenter.default.post(name: .currentPlayerRate, object: nil, userInfo: ["rate":2])
                  }
             })
            
        }
        else{
            print("Either player or playercontroller is empty")
        }
        
    }
    
    func removeObserver(){
        //playerController.removeObserver(self, forKeyPath: #keyPath(AVPlayerViewController.videoBounds))
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
       // NotificationCenter.default.removeObserver(self)
        observer?.invalidate()
        observer = nil
    }
    
    func play() {
        
        if player?.timeControlStatus != AVPlayer.TimeControlStatus.playing {
           
            player?.play()
            
            self.isPlayed = true

            self.playerController.player = player
            
            self.playerController.view.frame = bounds
            
            self.addSubview(self.playerController.view)
            
        }
        
    }
    
    func pause() {
        player?.pause()
        self.isPlayed = false
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: CMTime.zero)
    }
    
    @objc func reachTheEndOfTheVideo(_ notification: Notification) {
        
//        if isLoop {
//            player?.pause()
//            player?.seek(to: CMTime.zero)
//            player?.play()
//        }
        print("Video End")
        NotificationCenter.default.post(name: .currentPlayerVideoEnd, object: nil)
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
//
//        if  object as AnyObject? === player{
//
//            if keyPath == #keyPath(AVPlayerViewController.videoBounds) {
//                // detect only changes
//                if let oldValue = change?[.oldKey] as? CGRect, oldValue != CGRect.zero, let newValue = change?[.newKey] as? CGRect {
//                    // no need to track the initial bounds change, and only changes
//                    if !oldValue.equalTo(CGRect.zero), !oldValue.equalTo(newValue) {
//
//                        if newValue.size.height < UIScreen.main.bounds.height {
//                           print("normal screen")
//                        }
//                        else {
//                           print("fullscreen")
//
//                            if keyPath == "rate", let player = object as? AVPlayer {
//                                if player.rate == 1 {
//                                    print("Playing in full screen")
//                                    self.isPlayerFullScreen = true
//                                }
//                                else{
//                                    print("Paused in full screen")
//                                    self.isPlayerFullScreen = false
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//
//            else if keyPath == "rate", let player = object as? AVPlayer {
//
//                if player.rate == 1 {
//                    print("Playing")
//                    self.isPlayed = true
//                    NotificationCenter.default.post(name: .currentPlayerRate, object: nil, userInfo: ["rate":1])
//                }
//                else {
//                    print("Paused")
//                    self.isPlayed = false
//                    NotificationCenter.default.post(name: .currentPlayerRate, object: nil, userInfo: ["rate":2])
//                }
//            }
//        }
//        else{
//            print("Avplayer is nil")
//        }
//    }
    
}

//MARK: - AVPlayer Delegates

extension AvpVideoPlayer: AVPlayerViewControllerDelegate {

    func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {

        // The system pauses when returning from full screen, we need to 'resume' manually.
        coordinator.animate(alongsideTransition: nil) { transitionContext in
            
            if self.isPlayerFullScreen{
            self.player?.play()
            }
            else{
                self.player?.pause()
            }
              
        }
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, willBeginFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: nil) { transitionContext in
            self.isPlayerFullScreen = self.isPlayed
        }
    }
}
