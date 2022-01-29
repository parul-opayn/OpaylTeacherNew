//
//  ReviewTableViewCell.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 11/11/21.
//

import UIKit
import FloatRatingView
import WCLShineButton

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewerImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var timeSpanLbl: UILabel!
    @IBOutlet weak var reviewLbl: UILabel!
    
    //MoreCell
    @IBOutlet weak var moreLbl: UILabel!
    @IBOutlet weak var moreDetailLbl: UILabel!
    @IBOutlet weak var moreImage: UIImageView!
    @IBOutlet weak var moreImageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
