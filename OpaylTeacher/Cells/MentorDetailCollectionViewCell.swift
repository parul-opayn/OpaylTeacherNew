//
//  MentorDetailCollectionViewCell.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 14/12/21.
//

import UIKit
import FloatRatingView

class MentorDetailCollectionViewCell: UICollectionViewCell {
    
    //Specialisation
    @IBOutlet weak var specialistLLbl: UILabel!
    
    //certified by
    @IBOutlet weak var certificateImage: UIImageView!
    
    //ClassDetail
    @IBOutlet weak var classImage: UIImageView!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classDate: UILabel!
    @IBOutlet weak var classTime: UILabel!
    @IBOutlet weak var buyNowBtn: SetButton!
    
    //JoinClass
    @IBOutlet weak var joinClassBtn: SetButton!
    @IBOutlet weak var mentorName: UILabel!
    @IBOutlet weak var classDateTime: UILabel!
    @IBOutlet weak var classRating: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var viewsLbl: UILabel!
    @IBOutlet weak var ratingStarImage: UIImageView!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var ratingWidth: NSLayoutConstraint!
}
