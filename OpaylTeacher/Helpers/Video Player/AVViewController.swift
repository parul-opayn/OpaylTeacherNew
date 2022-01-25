//
//  AVViewController.swift
//  Chato
//
//  Created by promatics on 1/20/21.
//  Copyright © 2021 Promatics. All rights reserved.
//

import Foundation
import UIKit

class AVViewController: UIViewController {

    // MARK:- Outlets
    
    @IBOutlet var avPlayerView: AvpVideoPlayer!
    
    // MARK:- Variables
    
    var videoUrl = ""
    
    // MARK:- View Functions
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(red: 150/255, green: 11/255, blue: 15/255, alpha: 1)
        self.navigationController?.isNavigationBarHidden = false
        avPlayerView.configure(url: videoUrl, fullscreen: false)
        avPlayerView.isLoop = false
        avPlayerView.play()
//        let backBtn = UIButton()
//        backBtn.setImage(UIImage(named: "close btn"), for: .normal)
//        backBtn.addTarget(self, action: #selector(cancelBtnTapped(_:)), for: .touchUpInside)
//        backBtn.tintColor = .white
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        navigationWithBack(navtTitle: "", titleType: .normal, titleColor: .black)
    }
    
    @objc func cancelBtnTapped(_ sender: Any) {
        print("cancel tapped")
        avPlayerView.pause()
        navigationController?.popViewController(animated: true)
    }
    
  
}
