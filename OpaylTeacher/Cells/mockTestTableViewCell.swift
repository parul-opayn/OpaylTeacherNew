//
//  mockTestTableViewCell.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 22/10/21.
//

import UIKit

class mockTestTableViewCell: UITableViewCell {

    
    @IBOutlet weak var testTile: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var totalAttemptsLbl: UILabel!
    @IBOutlet weak var totalQuestionsLbl: UILabel!
    @IBOutlet weak var testDurationLbl: UILabel!
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var goForwardBtn: UIButton!
    @IBOutlet weak var mainBackgroundView: SetView!
    
    @IBOutlet weak var overViewLbl: UILabel!
    
    //MoreOption
    @IBOutlet weak var optionLbl: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var optionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
