//
//  PackagesTableViewCell.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 26/10/21.
//

import UIKit
import FloatRatingView
import SkeletonView
import SDWebImage

class PackagesTableViewCell: UITableViewCell {

    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var courseDateLbl: UILabel!
    @IBOutlet weak var calendarIcon: UIImageView!
    @IBOutlet weak var packageMainViewBottom: NSLayoutConstraint!
    
    
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var ratingViewWidth: NSLayoutConstraint!
    @IBOutlet weak var lessonsLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var amountView: SetView!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var percentView: UIProgressView!
    @IBOutlet weak var percentLbl: UILabel!
    @IBOutlet weak var videoLbl: UILabel!
    @IBOutlet weak var mockTestLbl: UILabel!
    @IBOutlet weak var studyMaterialLbl: UILabel!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var courseTImeSlotLbl: UILabel!
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var teacherExpericeLbl: UILabel!
    @IBOutlet weak var courseRatingLbl: UILabel!
    @IBOutlet weak var rateIcon: UIImageView!
    
    //Payment List cell
    
    @IBOutlet weak var packageType: UILabel!
    @IBOutlet weak var paideBy: UILabel!
    @IBOutlet weak var paidOnDate: UILabel!
    @IBOutlet weak var paymentStatusLbl: UILabel!
    
    //Class Cell
    @IBOutlet weak var classImage: SetImage!
    @IBOutlet weak var tutorName: UILabel!
    @IBOutlet weak var tutorExperience: UILabel!
    @IBOutlet weak var ratingStarImage: UIImageView!
    @IBOutlet weak var classRatingLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var classTimingLbl: UILabel!
    @IBOutlet weak var bookingAmount: UILabel!
    
    
    //Favorites Outlets
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var timeSlotLbl: UILabel!
   // @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var courseNameLbl: UILabel!
   // @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateTimeStack: UIStackView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
