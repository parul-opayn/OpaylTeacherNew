//
//  SideMenuTableViewCell.swift
//  Hart Store
//
//  Created by OPAYN LLC on 29/09/21.
//

import UIKit
import FloatRatingView
import RangeSeekSlider

class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var menuLbl: UILabel!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var ratingViewWidth: NSLayoutConstraint!
    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var innerTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var settingIcon: UIImageView!
    
    @IBOutlet weak var mainHeadingLbl: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var arrowBtn: UIButton!
    @IBOutlet weak var innerView: SetView!
    @IBOutlet weak var innerTableTop: NSLayoutConstraint!
    @IBOutlet weak var innerTableBottom: NSLayoutConstraint!
    @IBOutlet weak var innerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var mainHeadingLblTop: NSLayoutConstraint!
    
    //LoggedInUser
    @IBOutlet weak var viewName: UILabel!
    @IBOutlet weak var viewIcon: UIImageView!
    
    //Range Slider
    
    @IBOutlet weak var durationSlider: RangeSeekSlider!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var minimumHours: UILabel!
    @IBOutlet weak var maximumHours: UILabel!
    
    
    var viewController:UIViewController?
    var sideMenu: UIViewController?
    var menuSubData = [subMenu]()
    var mainIndex = -1
   // var viewModel = FilterViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.viewController?.updateTableHeight(tableName: self.innerTableView, tableHeight: self.tableViewHeight)
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        if isSelected{
//            self.contentView.backgroundColor = UIColor(named: "AppMainPink")?.withAlphaComponent(0.3)
//            //self.menuLbl.textColor =  UIColor(named:"AppPurple")!
//        }
//        else{
//            self.contentView.backgroundColor = .clear
//        }
    }
    
    override func prepareForReuse() {
        
    }
    
}

//MARK: - TableView Functions

extension SideMenuTableViewCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuSubData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "innerCell") as! SideMenuTableViewCell
        cell.menuLbl.text = menuSubData[indexPath.row].viewName
        cell.settingIcon.image = menuSubData[indexPath.row].image ?? UIImage(named: "Icon awesome-file-alt")
        cell.settingIcon.isHidden = true
     
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        switch mainIndex {
//
//        case 0:
//
//            if UserDefault.sharedInstance?.getUserDetails()?.id == nil{
//
//                switch indexPath.row {
//                case 0:
//                    break
//
//                case 1:
//                    break
//
//                case 2:
//                    break
//
//                case 3:
//
//                NotificationCenter.default.post(name: .ieltsPreference, object: nil)
//
//                default:
//                    break
//                }
//            }
//            else{
//
//                switch indexPath.row{
//
//                case 0:
//                    print("Dashboard")
//                    self.viewController?.tabBarController?.selectedIndex = 4
//                    break
//
//                case 1:
//                    print("Settings")
//                    let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
//                    vc.hidesBottomBarWhenPushed = true
//                    self.viewController?.navigationController?.pushViewController(vc, animated: true)
//
//                    break
//
//                case 2:
//
//                    print("Notification")
//
//                    let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
//                    vc.hidesBottomBarWhenPushed = true
//                    self.viewController?.navigationController?.pushViewController(vc, animated: true)
//                    break
//
//                default:
//                    break
//                }
//
//            }
//
//            break
//
//        case 1:
//
//            if UserDefault.sharedInstance?.getUserDetails()?.id == nil{
//
//            }
//            else{
//                switch indexPath.row{
//
//                case 0:
//                    print("Contact Us")
//                    let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "ContactusViewController") as! ContactusViewController
//                    vc.hidesBottomBarWhenPushed = true
//                    self.viewController?.navigationController?.pushViewController(vc, animated: true)
//                    break
//
//                case 1:
//                    print("FAQ's")
//                    let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "FaqViewController") as! FaqViewController
//                    vc.hidesBottomBarWhenPushed = true
//                    self.viewController?.navigationController?.pushViewController(vc, animated: true)
//                    break
//
//                default:
//                    break
//                }
//            }
//
//            break
//
//        case 2:
//
//            if UserDefault.sharedInstance?.getUserDetails()?.id == nil{
//
//            }
//            else{
//
//                switch indexPath.row{
//
//                case 0:
//
//                    print("About us")
//
//                    let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "GeneralContentViewController") as! GeneralContentViewController
//                    vc.displayDataFor = .aboutUs
//                    vc.hidesBottomBarWhenPushed = true
//                    self.viewController?.navigationController?.pushViewController(vc, animated: true)
//
//                    break
//
//                case 1:
//
//                    print("privacy policy")
//
//                    let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "GeneralContentViewController") as! GeneralContentViewController
//                    vc.hidesBottomBarWhenPushed = true
//                    vc.displayDataFor = .privacyPolicy
//                    self.viewController?.navigationController?.pushViewController(vc, animated: true)
//
//                    break
//
//                case 2:
//
//                    print("Terms")
//
//                    let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "GeneralContentViewController") as! GeneralContentViewController
//                    vc.hidesBottomBarWhenPushed = true
//                    vc.displayDataFor = .terms
//                    self.viewController?.navigationController?.pushViewController(vc, animated: true)
//
//                    break
//
//                default:
//                    break
//                }
//            }
//            break
//
//        default:
//            break
//        }
//
//        self.sideMenu?.dismiss(animated: true, completion: nil)
//    }
    
}

//extension SideMenuTableViewCell: RangeSeekSliderDelegate{
//    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
//        viewModel.minDurattinnRange = Int(ceil(minValue))
//        viewModel.maxDurationRange = Int(ceil(maxValue))
//    }
//}
