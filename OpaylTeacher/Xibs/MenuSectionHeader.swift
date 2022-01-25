//
//  MenuSectionHeader.swift
//  Hart Store
//
//  Created by OPAYN LLC on 01/10/21.
//

import UIKit

class MenuSectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var headingName: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var arrowImgWidth: NSLayoutConstraint!
    @IBOutlet weak var arrowImgHeight: NSLayoutConstraint!
    @IBOutlet weak var collapseBtn: UIButton!
    @IBOutlet weak var bottonView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func layoutForIpad(){
        headingName.changeFontSize()
        arrowImgWidth.constant = 30
        arrowImgHeight.constant = 20
    }

}
