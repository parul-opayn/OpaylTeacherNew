//
//  PlansView.swift
//  MVMC
//
//  Created by Promatics on 11/27/20.
//  Copyright © 2020 Promatics. All rights reserved.
//

import UIKit

class PlansView: UIView {
    
    //MARK:- Outlets
    @IBOutlet weak var planDescription_lbl: SetView!
    @IBOutlet weak var planPriceLbl: UILabel!
    @IBOutlet weak var planNameLbl: UILabel!
    
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var planName_lbl: SetView!
    @IBOutlet weak var buySubscription_btn: SetButton!
    
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var fourthLbl: UILabel!
    @IBOutlet weak var packageTypeLbl: UILabel!
    @IBOutlet weak var chooseBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var planPriceLblTop: NSLayoutConstraint!
    
    
    func layoutForIpad(){
        planPriceLbl.changeFontSize()
        planNameLbl.changeFontSize()
        buySubscription_btn.titleLabel?.changeFontSize()
        buySubscription_btn.changeButtonLayout()
        chooseBtnWidth.constant = 200
        secondLbl.changeFontSize()
        thirdLbl.changeFontSize()
        firstLbl.changeFontSize()
        fourthLbl.changeFontSize()
        packageTypeLbl.changeFontSize()
        planPriceLblTop.constant += 16
    }
    
}
