//
//  VideoDetaiView.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 01/11/21.
//

import UIKit
import FloatRatingView

class VideoDetailView: UIView {

    
    @IBOutlet weak var viewsStack: UIStackView!
    @IBOutlet weak var reviewRatingView: UIView!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var ratingViewWidth: NSLayoutConstraint!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var rateNumLbl: UILabel!
    @IBOutlet weak var buyView: UIView!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var buyBtn: SetButton!
    @IBOutlet weak var buyBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var studentNumLbl: UILabel!
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoLbl: UILabel!
    @IBOutlet weak var videoUnderLine: UIView!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewLbl: UILabel!
    @IBOutlet weak var reviewUnderLine: UIView!
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var reviewUnderline: UIView!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var messageUnderLine: UIView!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var messagesUnderline: UIView!
    @IBOutlet weak var moreLbl: UILabel!
    @IBOutlet weak var moreUndeLine: UIView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var moreUnderline: UIView!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var optionStackView: UIStackView!
    
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var optionsCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var buyBtnWidth: NSLayoutConstraint!
    
    var optionsData = ["Courses","Reviews","Mock Tests","Study Materials"]
    let cellIdentifier = "cellIdentifier"
    var selectedIndex = 0
    
    func setupCollectionView(){
        let nib = UINib(nibName: "PackageDetailsOptionsCell", bundle: nil)
        optionsCollectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)

        optionsCollectionView.delegate = self
        optionsCollectionView.dataSource = self
        
    }
    
    func layoutForIpad(){
        nameLbl.changeFontSize()
        ratingLbl.changeFontSize()
        rateNumLbl.changeFontSize()
        amountLbl.changeFontSize()
        buyBtn.titleLabel?.changeFontSize()
       // buyBtn.changeButtonLayout()
        buyBtnWidth.constant = 230
        buyBtnHeight.constant = 55
        descriptionLbl.changeFontSize()
        studentNumLbl.changeFontSize()
        videoLbl.changeFontSize()
        reviewLbl.changeFontSize()
        messageLbl.changeFontSize()
        moreLbl.changeFontSize()
        viewsStack.spacing = 12
    }
    
}


extension VideoDetailView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return optionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = optionsCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PackageDetailsOptionsCell
        cell.optionsLbl.text = optionsData[indexPath.row]
      
        if selectedIndex == indexPath.row{
            cell.optionsLbl.textColor = .black
            cell.indicatorView.isHidden = false
        }
        else{
            cell.optionsLbl.textColor = UIColor(named: "AppDarkGray")
            cell.indicatorView.isHidden = true
        }
        
        if UIDevice().userInterfaceIdiom == .pad{
            cell.layoutForIpad()
        }
        else{
            print("running in iphone")
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        UIView.performWithoutAnimation {
            collectionView.reloadData()
        }
        NotificationCenter.default.post(name: .optionsIndex, object: nil, userInfo: ["index":indexPath.row])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
        }
    }
    
}
