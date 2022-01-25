//
//  PackageDetailsOptionsCell.swift
//  IletsLearning
//
//  Created by OPAYN on 02/12/21.
//

import UIKit

class PackageDetailsOptionsCell: UICollectionViewCell {

    @IBOutlet weak var optionsLbl: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func layoutForIpad(){
        optionsLbl.changeFontSize()
    }

}
