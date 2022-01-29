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
  //  var walkThroughData: WalkThroughDataModel?
    var selectedCourses = [Int]()
    private let footerView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
    var page = 0
    var hasAPILoaded = false
    var refershControl:UIRefreshControl!
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView = true
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.navigationController?.isNavigationBarHidden = false
        })
        self.bothSideIcons(titleString: "Dashboard", titleType: .large, leftIcon: UIImage(named: "barIcon")!, rightIcon: UIImage(), titleColor: .black, leftBtnType: .menu, rightBtnType: .addFeed)
        navigationButtonsDelegate = self
        
        if UserDefault.sharedInstance?.getUserDetails()?.id != nil{
            NotificationCenter.default.addObserver(self, selector: #selector(trackPresentedScreen), name: .trackPresentedScreen, object: nil)
        }
        
        self.refershControl = UIRefreshControl()
       
        self.refershControl.tintColor = UIColor.red
        
        self.refershControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        if UIDevice().userInterfaceIdiom == .pad{
            
           // popularClassesTableView.isHidden = true
            popularClassCollectionview.delegate = self
            popularClassCollectionview.dataSource = self
            self.popularClassCollectionview!.alwaysBounceVertical = true
            self.popularClassCollectionview!.addSubview(refershControl)
           
        }
        else{
            self.popularClassesTableView.isHidden = false
            self.popularClassesTableView!.addSubview(refershControl)
        }
       // popularClassesTableView.allowsSelection = true
        getDashboardData()
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.bothSideIcons(titleString: "Dashboard", titleType: .large, leftIcon: UIImage(named: "barIcon")!, rightIcon: UIImage(), titleColor: .black, leftBtnType: .menu, rightBtnType: .addFeed)
        navigationButtonsDelegate = self
        
        userGreetingLbl.text =  "Hello, " + (UserDefault.sharedInstance?.getUserDetails()?.name ?? "N/A").capitalized
        userEmailLbl.text = UserDefault.sharedInstance?.getUserDetails()?.email ?? ""
       // prefillUserData()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.bothSideIcons(titleString: "Dashboard", titleType: .large, leftIcon: UIImage(named: "barIcon")!, rightIcon: UIImage(), titleColor: .black, leftBtnType: .menu, rightBtnType: .addFeed)
        navigationButtonsDelegate = self
    }
    
    //MARK: - custom method
    
    
//    func setView(){
//        //view.hideSkeleton()
//        if viewModel.dashboardModel?.myClasses?.count == 0{
//            joinClassView.isHidden = true
//            bookClassView.isHidden = false
//        }
//        else{
//            joinClassView.isHidden = false
//            bookClassView.isHidden = true
//            joinClassCollectionView.reloadData()
//        }
//
//        if viewModel.dashboardModel?.popularClass?.count == 0{
//            popularClassesView.isHidden = true
//        }
//        else{
//            popularClassesView.isHidden = false
//
//            if UIDevice().userInterfaceIdiom == .pad{
//                popularClassCollectionview.reloadData()
//                updateCollectionHeight(collectionName: popularClassCollectionview, collectionHeight: popularCollectonviewHeight)
//                updateCollectionHeight(collectionName: popularClassCollectionview, collectionHeight: popularCollectonviewHeight)
//            }
//            else{
//                popularClassesTableView.reloadData()
//                //updateTableHeight(tableName: popularClassesTableView, tableHeight: poplarClassesTabHeight)
//                //updateTableHeight(tableName: popularClassesTableView, tableHeight: poplarClassesTabHeight)
//            }
//
//        }
//
//        if viewModel.dashboardModel?.results?.count == nil || viewModel.dashboardModel?.results?.count == 0{
//            resultView.isHidden = true
//        }
//        else{
//            resultView.isHidden = false
//            resultCollectionView.reloadData()
//        }
//
//        if viewModel.dashboardModel?.myPackages?.count == 0 || viewModel.dashboardModel?.myPackages?.count == nil{
//            myPackages = false
//            if viewModel.dashboardModel?.availablePackages?.count == nil || viewModel.dashboardModel?.availablePackages?.count == 0{
//                packagesView.isHidden = true
//            }
//            else{
//                packageLbl.text = "Packages Available"
//                packagesView.isHidden = false
//                packageTableView.reloadData()
//              //  updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
//               // updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
//            }
//        }
//        else{
//            myPackages = true
//            packageLbl.text = "My Packages"
//            packagesView.isHidden = false
//            packageTableView.reloadData()
//           // updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
//          //  updateTableHeight(tableName: packageTableView, tableHeight: packageTabHeight)
//        }
//
//        if viewModel.dashboardModel?.myCourses?.count == nil || viewModel.dashboardModel?.myCourses?.count == 0{
//            myCourses = false
//            if viewModel.dashboardModel?.popularCourses?.count == nil || viewModel.dashboardModel?.popularCourses?.count == 0{
//                coursesView.isHidden = true
//            }
//            else{
//                coursesLbl.text = "Popular Courses"
//                coursesCollectionView.reloadData()
//            }
//        }
//        else{
//            myCourses = true
//            coursesLbl.text = "My Courses"
//            coursesCollectionView.reloadData()
//        }
//
//        if viewModel.dashboardModel?.recentlyViewed?.count == nil || viewModel.dashboardModel?.recentlyViewed?.count == 0{
//            recentViewedView.isHidden = true
//        }
//        else{
//            recentViewedView.isHidden = false
//            recentViewedTableView.reloadData()
//          //  updateTableHeight(tableName: recentViewedTableView, tableHeight: recentViewTabHeight)
//           // updateTableHeight(tableName: recentViewedTableView, tableHeight: recentViewTabHeight)
//        }
//
//        if resultView.isHidden && recentViewedView.isHidden{
//            if stackView.subviews[1] == packagesView{
//                if let myView = stackView.subviews[1] as? Any {
//                    stackView.removeArrangedSubview(myView as! UIView)
//                    stackView.setNeedsLayout()
//                    // stackView.layoutIfNeeded()
//
//                    stackView.insertArrangedSubview(myView as! UIView, at: 2)
//                    stackView.setNeedsLayout()
//                }
//            }
//        }
//        else{
//            if let myView = stackView.subviews[2] as? Any {
//                stackView.removeArrangedSubview(myView as! UIView)
//                stackView.setNeedsLayout()
//                //stackView.layoutIfNeeded()
//
//                stackView.insertArrangedSubview(myView as! UIView, at: 1)
//                stackView.setNeedsLayout()
//            }
//        }
//
//        joinClassPageControl.numberOfPages = viewModel.dashboardModel?.myClasses?.count ?? 2
//        if UIDevice().userInterfaceIdiom == .pad{
//            joinClassPageControl.subviews.forEach {
//                $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//            }
//        }
//    }
    
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
    
    @objc func refresh(sender:AnyObject)
    {
        self.refershControl.beginRefreshing()
            print("REFRESH SCREEN")
        page = 1
        getDashboardData()
        self.hasAPILoaded = false
        self.viewModel.dashboardModel = []
       
        if UIDevice().userInterfaceIdiom == .pad{
            popularClassCollectionview.reloadData()
        }
        else{
            popularClassesTableView.reloadData()
        }

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
                return 0
                //viewModel.dashboardModel?.myPackages?.count ?? 5
            }
            else{
                return 4
                //viewModel.dashboardModel?.availablePackages?.count ?? 5
            }
        }
        else if tableView == popularClassesTableView{
           
            let count = viewModel.dashboardModel.count
            
            if count != 0{
                return count
            }
            else{
                if hasAPILoaded{
                    tableCollectionErrors(view: tableView, text: "No data found", headerHeight: 0)
                    return count
                }
                else{
                    tableCollectionErrors(view: tableView, text: "", headerHeight: 0)
                    return 4
                }
               
            }
            
        }
        else{
            return 0
            //viewModel.dashboardModel?.recentlyViewed?.count ?? 0
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
//                if myPackages{
//                    model = viewModel.dashboardModel?.myPackages?[indexPath.row]
//                    cell.amountView.isHidden = true
//                }
//                else{
//                    model = viewModel.dashboardModel?.availablePackages?[indexPath.row]
//                    cell.amountView.isHidden = false
//                }
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
        else
            if tableView == popularClassesTableView{
          
                let cell = tableView.dequeueReusableCell(withIdentifier: "popularClasses", for: indexPath) as! PackagesTableViewCell
                if viewModel.dashboardModel.count == 0{
                    cell.calendarIcon.isHidden = true
                    cell.clockIcon.isHidden = true
                    cell.startDateLbl.text = ""
                    cell.classTimingLbl.text = ""
                cell.contentView.showAnimatedSkeleton()
            }
            else{
                cell.contentView.hideSkeleton()
                cell.calendarIcon.isHidden = false
                cell.clockIcon.isHidden = false
                let model = viewModel.dashboardModel[indexPath.row]
                cell.classImage.sd_setImage(with: URL(string: model.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
                cell.nameLbl.text = model.title ?? ""
                cell.tutorName.text = model.teacher?.name ?? ""
                cell.tutorExperience.text = "(\(model.teacher?.experience ?? 0) Yrs Exp)"
              //  cell.bookingAmount.text = "$\(model.price ?? 0)"
                
                let startDate = model.startDate ?? ""
                let startDateConversion = Singleton.sharedInstance.UTCToLocal(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd-MMM-yyyy")
                let startDateTime = Singleton.sharedInstance.UTCToLocal(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                let startStringToDate = Singleton.sharedInstance.UTCToLocalDate(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                
                let endDate = model.endDate ?? ""
                
                let endDateTime = Singleton.sharedInstance.UTCToLocal(date: endDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                let endStringToDate = Singleton.sharedInstance.UTCToLocalDate(date: endDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                
                let totalDaysOfCourse = endStringToDate.days(from: startStringToDate)
                
               
                cell.startDateLbl.text = "\(startDateConversion), \(totalDaysOfCourse) Days"
                cell.classTimingLbl.text = "\(startDateTime)-\(endDateTime)"
                
                if model.rating == nil{
                    //cell.ratingStarImage.image = UIImage(named: "emptyStar")
                    cell.classRatingLbl.text = "Not Rated"
                }
                else{
                    //cell.ratingStarImage.image = UIImage(named: "star")
                    cell.classRatingLbl.text = "\(model.rating ?? 0.0)"
                }
                
                cell.classImage.roundCorners([.topLeft,.bottomLeft], radius: 8)
                cell.layerView.roundCorners([.topLeft,.bottomLeft], radius: 8)
            }
                
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PackagesTableViewCell") as! PackagesTableViewCell
//            let model = viewModel.dashboardModel?.recentlyViewed?[indexPath.row]
//            cell.nameLbl.text = (model?.title ?? "").capitalized
//            cell.courseImage.sd_setImage(with: URL(string: model?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if viewModel.dashboardModel.count > 0{
            
            if (indexPath.row == viewModel.dashboardModel.count - 1) && (self.page <= viewModel.totalPages){
                
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
                self.getDashboardData()
            }
            else{
                print("pagination over")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.dashboardModel.count != 0{
            let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "SelectedClassViewController") as! SelectedClassViewController
            vc.classId = "\(viewModel.dashboardModel[indexPath.row].id ?? 0)"
            vc.className = viewModel.dashboardModel[indexPath.row].title ?? ""
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK: - CollectionView Delegate

extension MainDashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        if collectionView == popularClassCollectionview{
            let count = viewModel.dashboardModel.count
            
            if count != 0{
                return count
            }
            else{
                return 4
            }
            
        }
        else{

            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == popularClassCollectionview{
          
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularClassCell", for: indexPath) as! CoursesCollectionViewCell
          
            if viewModel.dashboardModel.count == 0{
                cell.contentView.showAnimatedSkeleton()
            }
            else{
                cell.contentView.hideSkeleton()
                let model = viewModel.dashboardModel[indexPath.row]
                
                cell.classImage.sd_setImage(with: URL(string: model.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
                cell.nameLbl.text = model.title ?? ""
                cell.tutorName.text = model.teacher?.name ?? ""
                cell.tutorExperience.text = "(\(model.teacher?.experience ?? 0) Yrs Exp)"
             //   cell.bookingAmount.text = "$\(model?.price ?? 0)"
                
                let startDate = model.startDate ?? ""
                let startDateConversion = Singleton.sharedInstance.UTCToLocal(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd-MMM-yyyy")
                let startDateTime = Singleton.sharedInstance.UTCToLocal(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                let startStringToDate = Singleton.sharedInstance.UTCToLocalDate(date: startDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                
                let endDate = model.endDate ?? ""
                
                let endDateTime = Singleton.sharedInstance.UTCToLocal(date: endDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
                let endStringToDate = Singleton.sharedInstance.UTCToLocalDate(date: endDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
                
                let totalDaysOfCourse = endStringToDate.days(from: startStringToDate)
                
               
                cell.startDateLbl.text = "\(startDateConversion), \(totalDaysOfCourse) Days"
                cell.classTimingLbl.text = "\(startDateTime)-\(endDateTime)"
                
                if model.rating == nil{
                    //cell.ratingStarImage.image = UIImage(named: "emptyStar")
                    cell.ratingView.maxRating = 1
                    cell.ratingView.rating = 1
                    cell.ratingViewWidth.constant = 20
                    cell.classRatingLbl.text = "Not Rated"
                }
                else{
                    //cell.ratingStarImage.image = UIImage(named: "star")
                    cell.ratingView.maxRating = 5
                    cell.ratingView.rating = model.rating ?? 0.0
                    cell.ratingViewWidth.constant = 100
                    cell.classRatingLbl.text = "\(model.rating ?? 0.0)"
                }
                cell.classImage.roundCorners([.topLeft,.bottomLeft], radius: 8)
                cell.layerView.roundCorners([.topLeft,.bottomLeft], radius: 8)
            }
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell", for: indexPath) as! CoursesCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if viewModel.dashboardModel.count > 0{
            
            if (indexPath.row == viewModel.dashboardModel.count - 1) && (self.page <= viewModel.totalPages){
                footerView.startAnimating()
                //self.hasAPILoaded = false
                self.getDashboardData()
            }
            else{
                print("pagination over")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
                   let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
                   footer.addSubview(footerView)
                   footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
                   return footer
               }
               return UICollectionReusableView()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == resultCollectionView{
            return CGSize(width: collectionView.bounds.width/3, height: 164)
        }
        else if collectionView == joinClassCollectionView{
            return CGSize(width: joinClassCollectionView.bounds.width, height: joinClassCollectionView.bounds.height)
        }
        else if collectionView == popularClassCollectionview{
            return CGSize(width: collectionView.bounds.width/2 - 10, height: collectionView.bounds.height / 2.2 - 10)
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
        if viewModel.dashboardModel.count != 0{
            let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "SelectedClassViewController") as! SelectedClassViewController
            vc.classId = "\(viewModel.dashboardModel[indexPath.row].id ?? 0)"
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        self.page += 1
        viewModel.dashboardApi(page: self.page,completion: {(isSuccess, message) in
            self.hasAPILoaded = true
            self.refershControl.endRefreshing()
            if isSuccess{
           
                if UIDevice().userInterfaceIdiom == .pad{
                    self.popularClassCollectionview.reloadData()
                }
                else{
                    self.popularClassesTableView.reloadData()
                }
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
