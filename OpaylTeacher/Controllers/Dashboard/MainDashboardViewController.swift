//
//  MainDashboardViewController.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 11/11/21.
//

import UIKit
import SideMenu
import iCarousel


class MainDashboardViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var userDetailView: UIView!
    @IBOutlet weak var userCourseLbl: UILabel!
    @IBOutlet weak var userGreetingLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    
    @IBOutlet weak var myClassesView: UIView!
    @IBOutlet weak var bookClassView: UIView!
    @IBOutlet weak var bookClassLbl: UILabel!
    @IBOutlet weak var browseClassBtn: SetButton!
    @IBOutlet weak var joinClassView: UIView!
    @IBOutlet weak var joinClassCollectionView: UICollectionView!
    @IBOutlet weak var joinClassPageControl: UIPageControl!
    @IBOutlet weak var joinClassCarouselView: iCarousel!
    
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    @IBOutlet weak var packagesView: UIView!
    @IBOutlet weak var viewPackagesBtn: SetButton!
    @IBOutlet weak var packageLbl: UILabel!
    @IBOutlet weak var packageTableView: UITableView!
    @IBOutlet weak var packageTabHeight: NSLayoutConstraint!
    
    @IBOutlet weak var coursesView: UIView!
    @IBOutlet weak var coursesLbl: UILabel!
    @IBOutlet weak var viewCoursesBtn: SetButton!
    @IBOutlet weak var coursesCollectionView: UICollectionView!
    
    @IBOutlet weak var popularClassesView: UIView!
    @IBOutlet weak var popularClassesBtn: SetButton!
    @IBOutlet weak var popularClassesTableView: UITableView!
    @IBOutlet weak var poplarClassesTabHeight: NSLayoutConstraint!
    
    @IBOutlet weak var recentViewedView: UIView!
    @IBOutlet weak var recentViewedTableView: UITableView!
    @IBOutlet weak var recentViewTabHeight: NSLayoutConstraint!
    @IBOutlet weak var popularClassCollectionview: UICollectionView!
    @IBOutlet weak var popularCollectonviewHeight: NSLayoutConstraint!
    
    //MARK: - Variables
    
    var viewModel = DashboardViewModel()
    var myPackages = false
    var myCourses = false
    var loadView = false
    var walkThroughData: WalkThroughDataModel?
    var selectedCourses = [Int]()

    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView = true
        //joinClassCarouselView.delegate = self
        //joinClassCarouselView.dataSource = self
        //joinClassCarouselView.type = .rotary
        //joinClassCarouselView.isVertical = false
       // joinClassCarouselView.isPagingEnabled = true
        //joinClassCarouselView.bounces = false
        
        updateTableHeight(tableName: popularClassesTableView, tableHeight: poplarClassesTabHeight)
        updateTableHeight(tableName: popularClassesTableView, tableHeight: poplarClassesTabHeight)
//        updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
//        updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
//        updateTableHeight(tableName: recentViewedTableView, tableHeight: recentViewTabHeight)
//        updateTableHeight(tableName: recentViewedTableView, tableHeight: recentViewTabHeight)
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.navigationController?.isNavigationBarHidden = false
        })
        self.bothSideIcons(titleString: "Dashboard", titleType: .large, leftIcon: UIImage(named: "barIcon")!, rightIcon: UIImage(), titleColor: .black, leftBtnType: .menu, rightBtnType: .addFeed)
        navigationButtonsDelegate = self
        
        if UserDefault.sharedInstance?.getUserDetails()?.id != nil{
            NotificationCenter.default.addObserver(self, selector: #selector(trackPresentedScreen), name: .trackPresentedScreen, object: nil)
        }
        
        if UIDevice().userInterfaceIdiom == .pad{
            //popularClassCollectionview.delegate = self
           // popularClassCollectionview.dataSource = self
           // popularClassCollectionview.isHidden = false
            popularClassesTableView.isHidden = true
        }
        else{
            self.popularClassesTableView.isHidden = false
           //` self.popularClassCollectionview.isHidden = true
        }
      //  getDashboardData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.bothSideIcons(titleString: "Dashboard", titleType: .large, leftIcon: UIImage(named: "barIcon")!, rightIcon: UIImage(), titleColor: .black, leftBtnType: .menu, rightBtnType: .addFeed)
        navigationButtonsDelegate = self
       // prefillUserData()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //MARK: - custom method
    
    func prefillUserData(){
        
        do{
            self.walkThroughData = try JSONDecoder().decode(WalkThroughDataModel.self, from: UserDefaults.standard.value(forKey: "WalkThroughJson") as! Data)
        }
        catch{
            print(error.localizedDescription)
        }
        
        if let userModel = UserDefault.sharedInstance?.getUserDetails(){
          
            if userModel.email != ""{
                userEmailLbl.text = userModel.email
            }
            let greetingText = "Hello, \(userModel.name ?? "")"
            let range = (greetingText as NSString).range(of: (userModel.name ?? ""))

            let mutableAttributedString = NSMutableAttributedString.init(string: greetingText)
            if UIDevice.current.userInterfaceIdiom == .pad{
                mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Asap-Bold", size: 46), range: range)
            }
            else{
                mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Asap-Bold", size: 36), range: range)
            }
            userGreetingLbl.attributedText = mutableAttributedString
        }
        else {
            print("userdata is nil")
        }
        self.selectedCourses = UserDefaults.standard.value(forKey: "UserCoursesId") as? [Int] ?? []
        if selectedCourses.count == 0{
            userCourseLbl.text = (walkThroughData?.services?.first?.name ?? "").capitalized
            selectedCourses.append(walkThroughData?.services?.first?.id ?? 0)
        }
        else{
            userCourseLbl.text = (walkThroughData?.services?.filter({selectedCourses.contains($0.id ?? 0)}).map({$0.name ?? ""}))?.joined(separator: ", ")
        }
    }
    
    func setView(){
        //view.hideSkeleton()
        if viewModel.dashboardModel?.myClasses?.count == 0{
            joinClassView.isHidden = true
            bookClassView.isHidden = false
        }
        else{
            joinClassView.isHidden = false
            bookClassView.isHidden = true
            joinClassCollectionView.reloadData()
        }
        
        if viewModel.dashboardModel?.popularClass?.count == 0{
            popularClassesView.isHidden = true
        }
        else{
            popularClassesView.isHidden = false
            if UIDevice().userInterfaceIdiom == .pad{
                popularClassCollectionview.reloadData()
                updateCollectionHeight(collectionName: popularClassCollectionview, collectionHeight: popularCollectonviewHeight)
                updateCollectionHeight(collectionName: popularClassCollectionview, collectionHeight: popularCollectonviewHeight)
            }
            else{
                popularClassesTableView.reloadData()
                updateTableHeight(tableName: popularClassesTableView, tableHeight: poplarClassesTabHeight)
                updateTableHeight(tableName: popularClassesTableView, tableHeight: poplarClassesTabHeight)
            }
           
        }
        
        if viewModel.dashboardModel?.results?.count == nil || viewModel.dashboardModel?.results?.count == 0{
            resultView.isHidden = true
        }
        else{
            resultView.isHidden = false
            resultCollectionView.reloadData()
        }
        
        if viewModel.dashboardModel?.myPackages?.count == 0 || viewModel.dashboardModel?.myPackages?.count == nil{
            myPackages = false
            if viewModel.dashboardModel?.availablePackages?.count == nil || viewModel.dashboardModel?.availablePackages?.count == 0{
                packagesView.isHidden = true
            }
            else{
                packageLbl.text = "Packages Available"
                packagesView.isHidden = false
                packageTableView.reloadData()
                updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
                updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
            }
        }
        else{
            myPackages = true
            packageLbl.text = "My Packages"
            packagesView.isHidden = false
            packageTableView.reloadData()
            updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
            updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
        }
        
        if viewModel.dashboardModel?.myCourses?.count == nil || viewModel.dashboardModel?.myCourses?.count == 0{
            myCourses = false
            if viewModel.dashboardModel?.popularCourses?.count == nil || viewModel.dashboardModel?.popularCourses?.count == 0{
                coursesView.isHidden = true
            }
            else{
                coursesLbl.text = "Popular Courses"
                coursesCollectionView.reloadData()
            }
        }
        else{
            myCourses = true
            coursesLbl.text = "My Courses"
            coursesCollectionView.reloadData()
        }
        
        if viewModel.dashboardModel?.recentlyViewed?.count == nil || viewModel.dashboardModel?.recentlyViewed?.count == 0{
            recentViewedView.isHidden = true
        }
        else{
            recentViewedView.isHidden = false
            recentViewedTableView.reloadData()
            updateTableHeight(tableName: recentViewedTableView, tableHeight: recentViewTabHeight)
            updateTableHeight(tableName: recentViewedTableView, tableHeight: recentViewTabHeight)
        }
        
        if resultView.isHidden && recentViewedView.isHidden{
            if stackView.subviews[1] == packagesView{
                if let myView = stackView.subviews[1] as? Any {
                    stackView.removeArrangedSubview(myView as! UIView)
                    stackView.setNeedsLayout()
                    // stackView.layoutIfNeeded()
                    
                    stackView.insertArrangedSubview(myView as! UIView, at: 2)
                    stackView.setNeedsLayout()
                }
            }
        }
        else{
            if let myView = stackView.subviews[2] as? Any {
                stackView.removeArrangedSubview(myView as! UIView)
                stackView.setNeedsLayout()
                //stackView.layoutIfNeeded()
                
                stackView.insertArrangedSubview(myView as! UIView, at: 1)
                stackView.setNeedsLayout()
            }
        }
        
        joinClassPageControl.numberOfPages = viewModel.dashboardModel?.myClasses?.count ?? 2
        if UIDevice().userInterfaceIdiom == .pad{
            joinClassPageControl.subviews.forEach {
                $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        }
    }
    
    //MARK: - Objc Methods
    
    @objc func didTapJoinClass(sender:UIButton){
        let btnTitle = sender.titleLabel?.text ?? ""
        
//        if btnTitle == " Join Class"{
//            let vc = storyboard?.instantiateViewController(withIdentifier: "SelectedClassViewController") as! SelectedClassViewController
//            vc.classId = "\(viewModel.dashboardModel?.myClasses?[sender.tag].onlineClassID?.first?.id ?? 0)"
//            vc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        else{
//            self.showToast(message: btnTitle)
//        }
        
    }
    
    @objc func trackPresentedScreen(sender:Notification){
        
//        if let userInfo = sender.object as? [String:Any]{
//            if let screenName = userInfo["screen"] as? UIViewController{
//                let name = getScreenName(name: screenName)
//                self.trackUser(screenName: name)
//            }
//            else{
//                print("******** ALERT*********** \n Notificaiton received but screen name is empty")
//            }
//        }
//        else{
//            print("******** ALERT*********** \n Notificaiton received but userInfo is empty")
//        }
        
    }
    
    //MARK: - IBActions
    
    @IBAction func tapBrowseClass(_ sender: Any) {
        self.tabBarController?.selectedIndex = 3
    }
    
    @IBAction func tapViewMoreClass(_ sender: Any) {
        self.tabBarController?.selectedIndex = 3
    }
    
    @IBAction func tapViewMorePackages(_ sender: Any) {
//        if myPackages{
//            let vc = storyboard?.instantiateViewController(withIdentifier: "MyPackagesViewController") as! MyPackagesViewController
//            vc.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(vc, animated: true)
//        }else{
//            let vc = storyboard?.instantiateViewController(withIdentifier: "PackagesViewController") as! PackagesViewController
//            vc.fromTabBar = false
//            vc.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    @IBAction func tapViewMoreCourses(_ sender: Any) {
//        let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "CoursesListViewController") as! CoursesListViewController
//        vc.hidesBottomBarWhenPushed = true
//        vc.fromTabBar = false
//        // vc.packageType = "Packages"
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - TableView delegate

extension MainDashboardViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == packageTableView{
            if myPackages{
                return viewModel.dashboardModel?.myPackages?.count ?? 5
            }
            else{
                return viewModel.dashboardModel?.availablePackages?.count ?? 5
            }
        }
        else if tableView == popularClassesTableView{
            return viewModel.dashboardModel?.popularClass?.count ?? 4
        }
        else{
            return viewModel.dashboardModel?.recentlyViewed?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == packageTableView{
          
            let cell = tableView.dequeueReusableCell(withIdentifier: "PackagesTableViewCell") as! PackagesTableViewCell
           
            if viewModel.dashboardModel == nil{
               // cell.contentView.showAnimatedSkeleton()
                //cell.amountView.BorderWidth = 0
               // packageLbl.showSkeleton()
                //viewPackagesBtn.showSkeleton()
            }
            else{
                cell.contentView.hideSkeleton()
                cell.amountView.BorderWidth = 1
                packageLbl.hideSkeleton()
                //viewPackagesBtn.hideSkeleton()
                var model: AvailablePackage?
                if myPackages{
                    model = viewModel.dashboardModel?.myPackages?[indexPath.row]
                    cell.amountView.isHidden = true
                }
                else{
                    model = viewModel.dashboardModel?.availablePackages?[indexPath.row]
                    cell.amountView.isHidden = false
                }
                cell.nameLbl.text = (model?.title ?? "").capitalized
                cell.courseImage.sd_setImage(with: URL(string: model?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
                cell.ratingView.editable = false
                if UIDevice.current.userInterfaceIdiom == .pad{
                    cell.ratingViewWidth.constant = 24
                }
                else{
                    cell.ratingViewWidth.constant = 14
                }
                cell.ratingView.maxRating = 1
                cell.ratingView.rating = 0
                cell.ratingLbl.text = "Not Rated"
                cell.amountLbl.text = "$\(Int(Double(model?.price ?? "0.0") ?? 0.0))"
            }
            return cell
            
        }
        else if tableView == popularClassesTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularClasses", for: indexPath) as! PackagesTableViewCell
            if viewModel.dashboardModel == nil{
               // cell.contentView.showAnimatedSkeleton()
            }
            else{
                cell.contentView.hideSkeleton()
                let model = viewModel.dashboardModel?.popularClass?[indexPath.row]
                cell.classImage.sd_setImage(with: URL(string: model?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
                cell.nameLbl.text = model?.title ?? ""
                cell.tutorName.text = model?.teacher?.name ?? ""
                cell.tutorExperience.text = "(\(model?.teacher?.profile?.experience ?? "") Yrs Exp)"
                cell.bookingAmount.text = "$\(model?.price ?? 0)"
                
                let startDate = model?.startDate ?? ""
                let startDateConversion = Singleton.sharedInstance.UTCToLocal(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd-MMM-yyyy")
                let startDateTime = Singleton.sharedInstance.UTCToLocal(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                let startStringToDate = Singleton.sharedInstance.UTCToLocalDate(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                
                let endDate = model?.endDate ?? ""
                
                let endDateTime = Singleton.sharedInstance.UTCToLocal(date: endDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                let endStringToDate = Singleton.sharedInstance.UTCToLocalDate(date: endDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                
                let totalDaysOfCourse = endStringToDate.days(from: startStringToDate)
                
               
                cell.startDateLbl.text = "\(startDateConversion), \(totalDaysOfCourse) Days"
                cell.classTimingLbl.text = "\(startDateTime)-\(endDateTime)"
                
                if model?.rating == nil{
                    //cell.ratingStarImage.image = UIImage(named: "emptyStar")
                    cell.classRatingLbl.text = "Not Rated"
                }
                else{
                    //cell.ratingStarImage.image = UIImage(named: "star")
                    cell.classRatingLbl.text = "\(model?.rating ?? 0.0)"
                }
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PackagesTableViewCell") as! PackagesTableViewCell
            let model = viewModel.dashboardModel?.recentlyViewed?[indexPath.row]
            cell.nameLbl.text = (model?.title ?? "").capitalized
            cell.courseImage.sd_setImage(with: URL(string: model?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView == packageTableView{
//            let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "PackageDetailsViewController") as! PackageDetailsViewController
//            var model: AvailablePackage?
//            if myPackages{
//                model = viewModel.dashboardModel?.myPackages?[indexPath.row]
//            }
//            else{
//                model = viewModel.dashboardModel?.availablePackages?[indexPath.row]
//            }
//            vc.mainTitle = model?.title ?? ""
//            vc.packageId = model?.id ?? 0
//            vc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//        else if tableView == popularClassesTableView{
//            let vc = storyboard?.instantiateViewController(withIdentifier: "SelectedClassViewController") as! SelectedClassViewController
//            vc.classId = "\(viewModel.dashboardModel?.popularClass?[indexPath.row].id ?? 0)"
//            vc.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
}

//MARK: - CollectionView Delegate

extension MainDashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if collectionView == joinClassCollectionView{
           
            return viewModel.dashboardModel?.myClasses?.count ?? 2
        }
        else if collectionView == resultCollectionView{
            return viewModel.dashboardModel?.results?.count ?? 3
        }
        else if collectionView == popularClassCollectionview{
            return viewModel.dashboardModel?.popularClass?.count ?? 4
        }
        else{
            if myCourses{
                return viewModel.dashboardModel?.myCourses?.count ?? 5
            }
            else{
                return viewModel.dashboardModel?.popularCourses?.count ?? 5
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == joinClassCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MentorDetailCollectionViewCell", for: indexPath) as! MentorDetailCollectionViewCell
            let model = viewModel.dashboardModel?.myClasses?[indexPath.row].onlineClassID
            if model?.count != 0{
                cell.classImage.sd_setImage(with: URL(string: model?[0].thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
                cell.mentorName.text = model?[0].title ?? "N/A"
                //model?[0].teacher?.name ?? "N/A"
                cell.className.text = "\(model?[0].seat ?? 0) seats left"
                //model?[0].title ?? "N/A"
                //cell.classDateTime.text = ""
//                if model?[0].rating == nil{
//                    //cell.ratingStarImage.image = UIImage(named: "emptyStar")
//                    cell.classRating.text = "Not Rated"
//                    cell.ratingView.rating = 1
//                    cell.ratingWidth.constant = 20
//                    cell.ratingView.maxRating = 1
//                }
//                else{
//                    //cell.ratingStarImage.image = UIImage(named: "star")
//                    cell.classRating.text = "\(model?[0].rating ?? 0.0)"
//                    cell.ratingView.rating = model?[0].rating ?? 0.0
//                    cell.ratingView.maxRating = 5
//                    cell.ratingWidth.constant = 100
//                }
                
                //Copied from SelectedClassViewController
                
                let startDateConversion = Singleton.sharedInstance.UTCToLocal(date: viewModel.dashboardModel?.myClasses?[indexPath.row].onlineClassID?.first?.startDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd-MMM-yyyy, hh:mm a")
                let startDateTime = Singleton.sharedInstance.UTCToLocal(date: viewModel.dashboardModel?.myClasses?[indexPath.row].onlineClassID?.first?.startDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                let startFullDate = Singleton.sharedInstance.UTCToLocalDate(date: viewModel.dashboardModel?.myClasses?[indexPath.row].onlineClassID?.first?.startDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd HH:mm:ss Z")
                
                //It's to display end date and time.
                
                let endFullDate = Singleton.sharedInstance.UTCToLocalDate(date: viewModel.dashboardModel?.myClasses?[indexPath.row].onlineClassID?.first?.endDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd HH:mm:ss Z")
                let endDateTime = Singleton.sharedInstance.UTCToLocal(date: viewModel.dashboardModel?.myClasses?[indexPath.row].onlineClassID?.first?.endDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                
                //It's current date time.
                
                let currentHours = Singleton.sharedInstance.UTCToLocal(date: "\(Date())", fromFormat: "yyyy-MM-dd HH:mm:ss Z", toFormat: "hh:mm a")
                
                let newStartDate = Singleton.sharedInstance.UTCToLocalDate(date: startDateTime, fromFormat: "hh:mm a", toFormat: "yyyy-MM-dd HH:mm:ss Z")
                let newEndDate = Singleton.sharedInstance.UTCToLocalDate(date: endDateTime, fromFormat: "hh:mm a", toFormat: "yyyy-MM-dd HH:mm:ss Z")
                let newCurrentDate = Singleton.sharedInstance.UTCToLocalDate(date: currentHours, fromFormat: "hh:mm a", toFormat: "yyyy-MM-dd HH:mm:ss Z")
                
                /**
                 Calculate Difference in start and end dates from the current date and let the user in if he reaches between start and end time.
                 */
                
                let currentDate = Date()
                let currentToStartDays = currentDate.days(from: startFullDate)
                let currentToEndDays = currentDate.days(from: endFullDate)
                
                let currentToStartMinutes = newCurrentDate.minutes(from: newStartDate)
                let currentToEndDateMinutes = newCurrentDate.minutes(from: newEndDate)
                
                if currentToStartDays >= 0 && currentToEndDays <= 0{
                    
                    //Course is currently ongoing. Check time to allow him inside the course.
                    
                    if currentToStartMinutes >= 0 && currentToEndDateMinutes <= 0{
                        
                        //Class has  been started
                        
                        cell.joinClassBtn.setTitle(" Join Class", for: .normal)
                        cell.joinClassBtn.alpha = 1
                    }
                    
                    else{
                        cell.joinClassBtn.setTitle(" Class not started", for: .normal)
                        cell.joinClassBtn.alpha = 0.5
                    }
                    
                }
                else if currentToStartDays >= 0 && currentToEndDays >= 0{
                    cell.joinClassBtn.setTitle(" Class Expired", for: .normal)
                    cell.joinClassBtn.alpha = 0.5
                }
                else{
                    cell.joinClassBtn.setTitle(" Class not started", for: .normal)
                    cell.joinClassBtn.alpha = 0.5
                }

                cell.classDateTime.text = startDateConversion
                cell.joinClassBtn.tag = indexPath.row
                cell.joinClassBtn.addTarget(self, action: #selector(didTapJoinClass), for: .touchUpInside)
            }
            return cell
        }
        if collectionView == resultCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardResultCollecViewCell", for: indexPath) as! DashboardResultCollecViewCell
            if viewModel.dashboardModel == nil{
                cell.contentView.showSkeleton()
            }else{
                cell.contentView.hideSkeleton()
                let model = viewModel.dashboardModel?.results?[indexPath.row]
                if self.loadView == true{
                    UIView.animate(withDuration: 2.5){
                        cell.progressBar.value = 1
                        cell.progressBar.value = model?.getMarks ?? 0.0
                        if indexPath.row == (self.viewModel.dashboardModel?.results?.count ?? 0) - 1{
                            self.loadView = false
                        }
                    }
                }
                else{
                    cell.progressBar.value = model?.getMarks ?? 0.0
                }
                cell.testName.text = (model?.testID?.title ?? "").capitalized
            }
            return cell
        }
        else if collectionView == popularClassCollectionview{
          
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularClassCell", for: indexPath) as! CoursesCollectionViewCell
          
            if viewModel.dashboardModel == nil{
                cell.contentView.showAnimatedSkeleton()
            }
            else{
                cell.contentView.hideSkeleton()
                let model = viewModel.dashboardModel?.popularClass?[indexPath.row]
                
                cell.classImage.sd_setImage(with: URL(string: model?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
                cell.nameLbl.text = model?.title ?? ""
                cell.tutorName.text = model?.teacher?.name ?? ""
                cell.tutorExperience.text = "(\(model?.teacher?.profile?.experience ?? "") Yrs Exp)"
             //   cell.bookingAmount.text = "$\(model?.price ?? 0)"
                
                let startDate = model?.startDate ?? ""
                let startDateConversion = Singleton.sharedInstance.UTCToLocal(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd-MMM-yyyy")
                let startDateTime = Singleton.sharedInstance.UTCToLocal(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                let startStringToDate = Singleton.sharedInstance.UTCToLocalDate(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                
                let endDate = model?.endDate ?? ""
                
                let endDateTime = Singleton.sharedInstance.UTCToLocal(date: endDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                let endStringToDate = Singleton.sharedInstance.UTCToLocalDate(date: endDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                
                let totalDaysOfCourse = endStringToDate.days(from: startStringToDate)
                
               
                cell.startDateLbl.text = "\(startDateConversion), \(totalDaysOfCourse) Days"
                cell.classTimingLbl.text = "\(startDateTime)-\(endDateTime)"
                
                if model?.rating == nil{
                    //cell.ratingStarImage.image = UIImage(named: "emptyStar")
                    cell.ratingView.maxRating = 1
                    cell.ratingView.rating = 1
                    cell.ratingViewWidth.constant = 20
                    cell.classRatingLbl.text = "Not Rated"
                }
                else{
                    //cell.ratingStarImage.image = UIImage(named: "star")
                    cell.ratingView.maxRating = 5
                    cell.ratingView.rating = model?.rating ?? 0.0
                    cell.ratingViewWidth.constant = 100
                    cell.classRatingLbl.text = "\(model?.rating ?? 0.0)"
                }
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell", for: indexPath) as! CoursesCollectionViewCell
            if viewModel.dashboardModel == nil{
                cell.contentView.showAnimatedSkeleton()
                cell.amountView.BorderWidth = 0
                coursesLbl.showSkeleton()
                //viewCoursesBtn.showSkeleton()
            }
            else{
                cell.contentView.hideSkeleton()
                coursesLbl.hideSkeleton()
                //viewCoursesBtn.hideSkeleton()
                cell.amountView.BorderWidth = 1
                cell.ratingView.editable = false
                var model: PopularCourse?
                if myCourses{
                    model = viewModel.dashboardModel?.myCourses?[indexPath.row]
                    cell.amountView.isHidden = true
                   // viewCoursesBtn.isHidden = true
                }
                else{
                    model = viewModel.dashboardModel?.popularCourses?[indexPath.row]
                    cell.amountView.isHidden = false
                    //viewCoursesBtn.isHidden = false
                }
                cell.imageView.sd_setImage(with: URL(string: model?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
//                if Singleton.sharedInstance.changeDateFormat(date: model?.hours ?? "", fromFormat: "HH:mm:ss", toFormat: "HH") == "00"{
//                    cell.timeLbl.text = Singleton.sharedInstance.changeDateFormat(date: model?.hours ?? "", fromFormat: "HH:mm:ss", toFormat: "mm:ss")
//                }else{
//                    cell.timeLbl.text = "\(model?.hours ?? "00:00")"
//                }
                cell.courseName.text = (model?.title ?? "").capitalized
                if (model?.video_count ?? 0) > 1{
                    cell.lessonLbl.text = "\(model?.video_count ?? 0) Lessons"
                }else{
                    cell.lessonLbl.text = "\(model?.video_count ?? 0) Lesson"
                }
                
                if model?.hours == nil {
                    cell.hoursLbl.text = "00:00 min"
                }
                else{
                    if Singleton.sharedInstance.changeDateFormat(date: model?.hours ?? "", fromFormat: "HH:mm:ss", toFormat: "HH") == "00"{
                        let mins = Singleton.sharedInstance.changeDateFormat(date: model?.hours ?? "", fromFormat: "HH:mm:ss", toFormat: "mm")
                        if (Int(mins) ?? 0) > 1{
                            cell.hoursLbl.text = "\(Singleton.sharedInstance.changeDateFormat(date: model?.hours ?? "", fromFormat: "HH:mm:ss", toFormat: "mm:ss")) mins"
                        }
                        else{
                            cell.hoursLbl.text = "\(Singleton.sharedInstance.changeDateFormat(date: model?.hours ?? "", fromFormat: "HH:mm:ss", toFormat: "mm:ss")) min"
                        }
                    }
                    else{
                        let hrs = Singleton.sharedInstance.changeDateFormat(date: model?.hours ?? "", fromFormat: "HH:mm:ss", toFormat: "HH")
                        if (Int(hrs) ?? 0) > 1{
                            cell.hoursLbl.text = "\(model?.hours ?? "") hrs"
                        }
                        else{
                            cell.hoursLbl.text = "\(model?.hours ?? "") hr"
                        }
                    }
                }
                
                if model?.rating == nil{
                    cell.ratingView.maxRating = 1
                    cell.ratingView.rating = 1
                    cell.ratingViewWidth = cell.ratingViewWidth.setMultiplier(multiplier: 0.09)
                    cell.ratingLbl.text = "Not Rated"
                    if UIDevice.current.userInterfaceIdiom == .pad{
                        cell.ratingViewWidth.constant = 24
                    }
                    else{
                        cell.ratingViewWidth.constant = 20
                    }
                }
                else{
                    cell.ratingView.rating = Double(model?.rating ?? "") ?? 0.0
                    cell.ratingView.maxRating = 5
                    cell.ratingLbl.text = model?.rating ?? ""
                    cell.ratingViewWidth = cell.ratingViewWidth.setMultiplier(multiplier: 0.4)
                    if UIDevice.current.userInterfaceIdiom == .pad{
                        cell.ratingViewWidth.constant = 110
                    }
                    else{
                        cell.ratingViewWidth.constant = 100
                    }
                }
                
                cell.amountLbl.text = "$\(model?.price ?? "0")"
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == resultCollectionView{
            return CGSize(width: collectionView.bounds.width/3, height: 164)
        }
        else if collectionView == joinClassCollectionView{
            return CGSize(width: joinClassCollectionView.bounds.width, height: joinClassCollectionView.bounds.height)
        }
        else if collectionView == popularClassCollectionview{
            return CGSize(width: collectionView.bounds.width/2 - 10, height: collectionView.bounds.height / 3 - 10)
        }
        else{
            return CGSize(width: collectionView.bounds.width/2 - 4, height: 230)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == popularClassCollectionview{
            return 15
        }
        else{
            return 0
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == popularClassCollectionview{
            return 10
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == coursesCollectionView{
//            let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "VideoPlayViewController") as! VideoPlayViewController
//            vc.isMyCourse = myCourses
//            if myCourses{
//                vc.courseId = viewModel.dashboardModel?.myCourses?[indexPath.row].id ?? 0
//                vc.courseTitle = viewModel.dashboardModel?.myCourses?[indexPath.row].title ?? ""
//            }
//            else{
//                vc.courseId = viewModel.dashboardModel?.popularCourses?[indexPath.row].id ?? 0
//                vc.courseTitle = viewModel.dashboardModel?.popularCourses?[indexPath.row].title ?? ""
//            }
//            vc.hidesBottomBarWhenPushed = true
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if  let collectionView = scrollView as? UICollectionView{
            if collectionView == joinClassCollectionView{
                let x = scrollView.contentOffset.x
                let w = scrollView.bounds.size.width
                let currentPage = Int(ceil(x/w))
                joinClassPageControl.currentPage = currentPage
            }
        }
    }
}

//MARK: - iCarouselDelegate methods
extension MainDashboardViewController: iCarouselDelegate,iCarouselDataSource{
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 1
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let cell = Bundle.main.loadNibNamed("MentorsView", owner: nil, options: nil)?.first as! MentorsView
        cell.frame = CGRect.init(x: 0, y: 10, width: joinClassCarouselView.bounds.width-0, height: self.joinClassCarouselView.frame.height-8)
        cell.joinBtnWidth.constant = 120
        cell.mentorNameTopConstraint.constant = 24
        return cell
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {

        case .spacing:

            return 0.2
            
        default:

            return value

        }
    }
}

//MARK: - Navigation button delegate

extension MainDashboardViewController: customNavigationDelegates{
    
    func didTapRightButton(buttonType type: rightButtontype){
        if  type == .cart{
            
        }
    }
    
    func didTapLeftbutton(buttonType type: LeftButtonType) {
        if type == .menu{
            let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
            let menu = SideMenuNavigationController(rootViewController: vc)
            menu.leftSide = true
            menu.presentationStyle = .menuSlideIn
            menu.menuWidth = self.view.bounds.width
            menu.presentDuration = 0.25
            vc.viewController = self
            menu.isNavigationBarHidden = true
            self.present(menu, animated: true, completion: nil)
            
        }
    }
}

//MARK: - Api call

extension MainDashboardViewController{
    
    func getDashboardData(){
        viewModel.dashboardApi(completion: {(isSuccess, message) in
            if isSuccess{
                //self.popularCollectonviewHeight.constant = 300
                self.setView()
            }
            else{
                
                if message.contains("Unable to Connect to Internet"){
                    
                    let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "NoInternetViewController") as!
                    NoInternetViewController
                    
                    vc.cb = {
                        shouldRetry in
                        
                        if shouldRetry{
                            
                            self.getDashboardData()
                            
                        }
                        else{
                            
                        }
                    }
                    
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                else{
                    self.showToast(message: message)
                }
            }
        })
    }
    
    func trackUser(screenName:String){
        
        DispatchQueue.global(qos: .background).async {
            
            let viewModlel = LoginViewModel()
            
            viewModlel.appTracking(screenName: screenName) { isSuccess, message in
                if isSuccess{
                    print("screen tracked")
                }
                else{
                    print("Not tracked")
                }
            }
        }
        
    }
    
}

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
