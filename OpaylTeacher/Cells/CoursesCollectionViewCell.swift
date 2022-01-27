//
//  CoursesCollectionViewCell.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 26/10/21.
//

import UIKit
import FloatRatingView

class CoursesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var imageView: SetImage!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var lessonLbl: UILabel!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var amountView: SetView!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var ratingViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var optionLbl: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    //Online Class Labels
    
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
   
    @IBOutlet weak var courseDateLbl: UILabel!
    @IBOutlet weak var courseTImeSlotLbl: UILabel!
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var teacherExpericeLbl: UILabel!
    @IBOutlet weak var calendarIcon: UIImageView!
    @IBOutlet weak var clockIcon: UIImageView!
    
    
    // Packages Cell
    
    @IBOutlet weak var videoLbl: UILabel!
    
    //Popular Class Collection
    
    @IBOutlet weak var classImage: SetImage!
    @IBOutlet weak var tutorName: UILabel!
    @IBOutlet weak var tutorExperience: UILabel!
    @IBOutlet weak var ratingStarImage: UIImageView!
    @IBOutlet weak var classRatingLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var classTimingLbl: UILabel!
    
}
