//
//  NoInternetViewController.swift
//  IletsLearning
//
//  Created by OPAYN on 22/11/21.
//

import UIKit

class NoInternetViewController: UIViewController {

    @IBOutlet weak var popUpImage: UIImageView!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var msgLblTop: NSLayoutConstraint!
    @IBOutlet weak var msgLblBottom: NSLayoutConstraint!
    @IBOutlet weak var connectBtn: SetButton!
    @IBOutlet weak var popUpImageHeight: NSLayoutConstraint!
    @IBOutlet weak var popUpImageWidth: NSLayoutConstraint!
    
    
    var cb:((Bool)->())?
    var displayScreenFor:displayPopUpFor = .internet
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if displayScreenFor == .internet{
           layoutViewForInternet()
        }
        else if displayScreenFor == .testFinsish{
            layoutViewForPurchase()
        }
        else{
            layoutViewForPurchase()
        }
        
    }
    
    func layoutViewForPurchase(){
        popUpImageHeight.constant = 150
        popUpImageWidth.constant = 150
        bgView.backgroundColor = .black.withAlphaComponent(0.3)
        messageLbl.isHidden = false
        msgLblTop.constant = 16
        msgLblBottom.constant = 16
        messageLbl.textColor = .black
        
        if displayScreenFor == .purchase{
            popUpImage.image = UIImage(named: "payment icon")
            messageLbl.text = "Course Purchased Successfully"
            connectBtn.setTitle("Done", for: .normal)
        }
        else if displayScreenFor == .purchaseClass{
            popUpImage.image = UIImage(named: "payment icon")
            messageLbl.text = "Class Booked Successfully"
            connectBtn.setTitle("Done", for: .normal)
        }
        else if displayScreenFor == .testFinsish{
            popUpImage.image = UIImage(named: "time's-up")
            messageLbl.text = ""
            connectBtn.setTitle("Submit", for: .normal)
        }
        else{
            popUpImage.image = UIImage(named: "payment icon")
            messageLbl.text = "Please purchase this course to watch this video"
            connectBtn.setTitle("Okay", for: .normal)
        }
        
        
    }
    
    func layoutViewForInternet(){
        popUpImage.image = UIImage(named: "lost-wireless-vector")
        popUpImageHeight.constant = 220
        popUpImageWidth.constant = 220
        bgView.backgroundColor = .white
        messageLbl.isHidden = false
        msgLblTop.constant = 0
        msgLblBottom.constant = 16
        messageLbl.textColor = UIColor(named: "AppMainPink")
        messageLbl.text = "Internet connection is not available"
        connectBtn.setTitle("ReConnect", for: .normal)
    }
    
    @IBAction func tappedRetryBtn(_ sender: UIButton) {
       
        self.dismiss(animated: true, completion: {
            self.cb?(true)
        })
    }
    
}
