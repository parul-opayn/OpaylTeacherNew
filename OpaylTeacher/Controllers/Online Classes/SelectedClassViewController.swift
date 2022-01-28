//
//  SelectedClassViewController.swift
//  IletsLearning
//
//  Created by OPAYN on 13/11/21.
//

import UIKit
import FloatRatingView
import GrowingTextView

class SelectedClassViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var classImage: SetImage!
    @IBOutlet weak var tutorName: UILabel!
    @IBOutlet weak var tutorQualification: UILabel!
    @IBOutlet weak var classBookingAmount: UILabel!
    @IBOutlet weak var ratingViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tutorExperienceLbl: UILabel!
    @IBOutlet weak var startDateLbl: UILabel!
    @IBOutlet weak var timeSlotLbl: UILabel!
    @IBOutlet weak var seatsLeftLbl: UILabel!
    @IBOutlet weak var classOverview: UILabel!
    @IBOutlet weak var headingCollectionview: UICollectionView!
    @IBOutlet weak var classTableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var registerBtn: SetButton!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var sendMessageView: UIView!
    @IBOutlet weak var sendMsgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var messageTxtView: GrowingTextView!
    @IBOutlet weak var moreAvailableView: UIView!
    @IBOutlet weak var moreAvailableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var moreAvailableBtn: UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var classTableWrapperView: UIView!
    @IBOutlet weak var attachmentBtn: UIButton!
    @IBOutlet weak var attachmentWidth: NSLayoutConstraint!
    
    
    //MARK: - Variables
    
    var classId = "1"
    var viewModel = OnlineClassViewModel()
    var courseViewModel = CourseDetailViewmodel()
    var dataArray = ["Messages","Overview","Study Material", "More"]
    var selectedIndex = 1
    var isFavourite = false
    var isMyClass = false
    var showAllMaterial = false
    var docPicker: DocumentPicker?
    var photosPicker: ImagePicker?
    var needRefresh = false
    var fileName:String?
    var fileType:String?
    var fileData:Data?
    
    //MARK: - Life cycle methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        headingCollectionview.delegate = self
        headingCollectionview.dataSource = self
        
        
        headingCollectionview.reloadData()
     //   classTableView.delegate = self
      //  classTableView.dataSource = self
        messageTxtView.delegate = self
        
        navigationWithBack(navtTitle: "IELTS Preparation", titleType: .large, titleColor: .black)
        classTableView.reloadData()
        setBottomView()
      //  updateTableHeight(tableName: classTableView, tableHeight: tableHeight)
        registerBtn.semanticContentAttribute = .forceRightToLeft
       // updateTableHeight(tableName: classTableView, tableHeight: tableHeight)
        headingCollectionview.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        ratingView.editable = false
        //docPicker = DocumentPicker(showOnViewController: self, delegate: self)
       // photosPicker = ImagePicker(presentationController: self, delegate: self)
        self.view.showAnimatedSkeleton()
        needRefresh = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.moreDataArray.removeAll()
        viewModel.moreDataArray.append(subMenu(viewName: "Share this class", image: UIImage(named: "shareRoundIcon")))
        viewModel.moreDataArray.append(subMenu(viewName: "Add to favorites", image: UIImage(named: "favouriteRoundIcon")))
        if needRefresh{
        getClassDetail()
        }
    }
    
    //MARK: - custom method
    
//    func moreTabRow(indexPath: IndexPath){
//
//        if indexPath.row == 0{
//            let text = "Online Class"
//            let textShare = [ text ]
//            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
//            activityViewController.popoverPresentationController?.sourceView = self.view
//            if UIDevice.current.userInterfaceIdiom == .pad {
//                activityViewController.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
//                activityViewController.popoverPresentationController?.permittedArrowDirections = []
//            }
//            self.present(activityViewController, animated: true, completion: nil)
//        }
//        else if indexPath.row == 1{
//            needRefresh = true
//            let vc1 = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "FavouriteClassesViewController") as! FavouriteClassesViewController
//            vc1.title = "Class Course"
//
//            let vc2 = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "FavouriteClassesViewController") as! FavouriteClassesViewController
//            vc2.title = "Video Course"
//
//            let controllers = [vc1,vc2]
//            let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
//            vc1.basController = vc
//            vc2.basController = vc
//            vc.controllerArray = controllers
//            navigationController?.pushViewController(vc, animated: true)
//
//        }
//        else if indexPath.row == 2{
//            needRefresh = true
//            let vc = storyboard?.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
//            vc.courseId = "\(viewModel.classDetail?.id ?? 0)"
//            vc.content = (viewModel.classDetail?.content ?? "").html2String
//            vc.isClass = true
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    func setBottomView(){
        
        classTableWrapperView.backgroundColor = .white
        //UIColor(named: "AppBackgroundGray")
        self.classTableView.backgroundColor = .white
        //UIColor(named: "AppBackgroundGray")
        if selectedIndex == 0{
            self.sendMessageView.isHidden = false
            if UIDevice.current.userInterfaceIdiom == .pad{
                self.sendMsgViewHeight.constant = 100
            }
            else{
                self.sendMsgViewHeight.constant = 80
            }
            //classTableWrapperView.backgroundColor = .cyan
            self.classTableView.backgroundColor = .white
           // self.messagesList()
        }
        else{
            self.sendMessageView.isHidden = true
            self.sendMsgViewHeight.constant = 0
        }
        
        if selectedIndex == 2 && !showAllMaterial{
            self.moreAvailableView.isHidden = false
            self.moreAvailableViewHeight.constant = 85
        }
        else{
            self.moreAvailableView.isHidden = true
            self.moreAvailableViewHeight.constant = 0
        }
        
    }
    
    func setData(){
       
        self.view.hideSkeleton()
        
        //It's to display the Date, days and time on the screen
        
        let startDateConversion = Singleton.sharedInstance.UTCToLocal(date: viewModel.classDetail?.startDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "dd-MMM-yyyy")
        let startDateTime = Singleton.sharedInstance.UTCToLocal(date: viewModel.classDetail?.startDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
        let startFullDate = Singleton.sharedInstance.UTCToLocalDate(date: viewModel.classDetail?.startDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd HH:mm:ss Z")
        
        //It's to display end date and time.
        
        let endFullDate = Singleton.sharedInstance.UTCToLocalDate(date: viewModel.classDetail?.endDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd HH:mm:ss Z")
        let endDateTime = Singleton.sharedInstance.UTCToLocal(date: viewModel.classDetail?.endDate ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "hh:mm a")
        
        //It's current date time.
        
        let currentHours = Singleton.sharedInstance.UTCToLocal(date: "\(Date())", fromFormat: "yyyy-MM-dd HH:mm:ss Z", toFormat: "hh:mm a")
    
        //The below code converts course's start, end and current time to same date i.e 2000-01-01. It's useful when comparing start and end time of the course. we can easily check when the course starts and ends.
        
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
        
        
        print("minutes over = \(currentToStartMinutes)","end minutes \(currentToEndDateMinutes)","start days \(currentToStartDays) end days \(currentToEndDays)")
        
        if viewModel.classDetail?.user?.count ?? 0 != 0{
            isMyClass = true
            dataArray = ["Messages","Overview","Study Material", "More"]
            
            if currentToStartDays >= 0 && currentToEndDays <= 0{
                
                //Course is currently ongoing. Check time to allow him inside the course.
                
                if currentToStartMinutes >= 0 && currentToEndDateMinutes <= 0{
                    
                    //Class has  been started
                    
                    registerBtn.setTitle(" Join Class", for: .normal)
                    registerBtn.alpha = 1
                }
                else{
                    registerBtn.setTitle(" Class not started", for: .normal)
                    registerBtn.alpha = 0.5
                }
                
            }
            else{
                registerBtn.setTitle(" Class not started", for: .normal)
                registerBtn.alpha = 0.5
            }
            
            
           // classBookingAmount.isHidden = false
            //true
            selectedIndex = 0
            setBottomView()
           
            if !viewModel.moreDataArray.contains(where: {$0.viewName == "Write Review"}){
                viewModel.moreDataArray.append(subMenu(viewName: "Write Review", image: UIImage(named: "reviewRoundIcon")))
            }
           
        }
        else{
            isMyClass = false
            dataArray = ["Overview", "Study Material", "More"]
           // classBookingAmount.isHidden = false
            registerBtn.setTitle("Book Class", for: .normal)
            registerBtn.alpha = 1
            selectedIndex = 1
        }
        
        if viewModel.classDetail?.wishlist != nil{
            self.isFavourite = true
        }
        else{
            self.isFavourite = false
        }
        
        navigationWithBack(navtTitle: viewModel.classDetail?.title ?? "", titleType: .large, titleColor: .black)
        classImage.sd_setImage(with: URL(string: viewModel.classDetail?.thumbnail ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
        tutorName.text = viewModel.classDetail?.teacher?.name ?? ""
        
        if let qualification = viewModel.classDetail?.teacher?.profile?.qualification?.title{
            tutorQualification.text = "(\(qualification)"
        }
        else{
            tutorQualification.text = ""
        }
       
        classBookingAmount.text = "$\(viewModel.classDetail?.price ?? 0)"
      
        if viewModel.classDetail?.teacher?.profile?.experience == nil{
            tutorExperienceLbl.text = "N/A"
        }
        else{
            tutorExperienceLbl.text = "\(viewModel.classDetail?.teacher?.profile?.experience ?? "") Years Experience"
        }
        
        seatsLeftLbl.text = "\(viewModel.classDetail?.seat ?? 0) Seats Left"
        
        var ratingString = ""
        
        if viewModel.classDetail?.rating == nil{
            ratingView.maxRating = 1
            ratingView.rating = 0
            if UIDevice.current.userInterfaceIdiom == .pad{
                ratingViewWidth.constant = 26
            }
            else{
                ratingViewWidth.constant = 16
            }
            ratingString = "Not Rated"
        }
        else{
            ratingView.maxRating = 5
            if UIDevice.current.userInterfaceIdiom == .pad{
                ratingViewWidth.constant = 120
            }
            else{
                ratingViewWidth.constant = 90
            }
            ratingView.rating = viewModel.classDetail?.rating ?? 0.0
            ratingString = "\(viewModel.classDetail?.rating ?? 0.0)"
        }
        if viewModel.classDetail?.reviewCount != nil{
            ratingString.append(" (\(viewModel.classDetail?.reviewCount ?? 0))")
        }
        ratingLbl.text = ratingString
        
        
        let timeDifference = endFullDate.days(from: startFullDate)
        
        startDateLbl.text = "\(startDateConversion) (\(timeDifference) Days)"
        timeSlotLbl.text = "\(startDateTime) - \(endDateTime)"
        classOverview.text = (viewModel.classDetail?.content ?? "").html2String
        headingCollectionview.reloadData()
        classTableView.reloadData()
        //updateTableHeight(tableName: classTableView, tableHeight: tableHeight)
    }
    
    //MARK: - objc func
    
    @objc func tapFavourite(_ sender: UIButton){
        if sender.tag == 1{
            //self.favouriteClass()
        }
    }
    
    @objc func downloadStudyMaterial(sender:UIButton){
    
        if viewModel.classDetail?.user?.count ?? 0 == 0{
            self.showToast(message: "Please purchase this course to download this study material")
        }
        else{
            if let url = URL(string: viewModel.classDetail?.studyMaterial?[sender.tag].material ?? ""){
                self.showToast(message: "Starting Download....")
                FileDownloader.loadFileAsync(url: url) { (path, error) in

                    DispatchQueue.main.async {
                        if let err = error{
                            self.dismissToast()
                            self.showToast(message: err.localizedDescription)
                            print(err.localizedDescription)
                        }
                        else{
                            self.dismissToast()
                            self.showToast(message: "Success. You can find file inside IELTS Learning Folder inside Files.")
                            print("PDF File downloaded to : \(path!)")
                        }
                    }
                }
            }
            else{
                self.showToast(message: "Invalid URL")
            }
        }
        
    }
    
    //MARK: - IBAction method
    
    @IBAction func tappedRegister(_ sender: UIButton) {
       
        
        if UserDefault.sharedInstance?.getUserDetails()?.id == nil{

            self.showAlertWithActionOkandCancel(Title: "", Message: "Please login to continue", OkButtonTitle: "OK",CancelButtonTitle:"Cancel") {
                let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.hideBack = false
                vc.moveBack = true
                self.navigationController?.pushViewController(vc, animated: true)
            }

        }
        else{

            if sender.titleLabel?.text?.contains("Book Class") ?? false{

//                let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
//                vc.classViewModel = self.viewModel
//                vc.classId = self.classId
//                vc.isFromClass = true
//                vc.cb = {
//                   [weak self] isSuccess in
//
//                    guard let self = self else{return}
//                    if isSuccess{
//
//                        self.viewModel.moreDataArray.removeAll()
//                        self.viewModel.moreDataArray.append(subMenu(viewName: "Share this class", image: UIImage(named: "shareRoundIcon")))
//                        self.viewModel.moreDataArray.append(subMenu(viewName: "Add to favorites", image: UIImage(named: "favouriteRoundIcon")))
//
//                        self.getClassDetail()
//                    }
//                    else{
//                        print("Transaction failure")
//                    }
//                }
//                navigationController?.pushViewController(vc, animated: true)

            }
            else if sender.titleLabel?.text?.contains("Class not started") ?? false{
                print(sender.titleLabel?.text ?? "")
 
            }
            else{
                print(sender.titleLabel?.text ?? "")
                
               // if let url = self.viewModel.classDetail?.participant_url{
                    
                    //let newLink = url.replacingOccurrences(of: "https://", with: "googlechrome://")
//
//                    UIApplication.shared.open(URL(string:  newLink)!, options: [:]) { isSuccess in
//                        if isSuccess{
//                            print("Opening google chrome")
//                        }
//                        else{
//                            print("Google chrome not opened")
                          //  UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
//                        }
//                    }
                    
//                    let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "") as! MyWebviewViewController
//                    vc.url = url
//                    self.present(vc, animated: true, completion: nil)
//                }
//                else{
//                    self.showToast(message: "Invalid url")
//                }
                
            }

        }
    }
  
    @IBAction func tapMoreAvailable(_ sender: Any) {
        showAllMaterial = true
        classTableView.reloadData()
      //  updateTableHeight(tableName: classTableView, tableHeight: tableHeight)
        setBottomView()
    }
    
    @IBAction func tappedSendMessage(_ sender: UIButton) {
      //  self.sendMessage(message: messageTxtView.text ?? "")
    }
    
    
    @IBAction func tappedFileBtn(_ sender: UIButton) {
        
//        if attachmentBtn.imageView?.image == UIImage(named: "redCross"){
//            self.fileData = nil
//            self.fileType = nil
//            self.fileName = nil
//            self.attachmentBtn.setImage(UIImage(named: "attachment"), for: .normal)
//            self.attachmentBtn.setTitle("", for: .normal)
//            attachmentWidth.constant = 30
//        }
//        else{
            needRefresh = false
            let optionMenu = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
            
            let docxAction = UIAlertAction(title: "Document", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.docPicker?.showDocumentPicker()
            })
            
            let photosAction = UIAlertAction(title: "Photos", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                //docPicker?.showDocumentPicker()
                self.photosPicker?.media = .photoGallery
                self.photosPicker?.upload = .photo
                self.photosPicker?.displayActionSheet = false
                self.photosPicker?.showPickerAlert(view: self.view)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
            })

            optionMenu.addAction(docxAction)
            optionMenu.addAction(photosAction)
            optionMenu.addAction(cancelAction)
            optionMenu.view.tintColor = .black
       
        if UIDevice().userInterfaceIdiom == .pad{
            //optionMenu.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            optionMenu.popoverPresentationController?.sourceView = sender
           // optionMenu.popoverPresentationController?.sourceRect = attachmentBtn.frame
        }
            self.present(optionMenu, animated: true, completion: nil)
       // }
       
    }
    
}

//MARK: - TextView Delegates

extension SelectedClassViewController: GrowingTextViewDelegate{
    
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        self.sendMsgViewHeight.constant = height + 60
    }
    
}

//MARK: - UICollectionView Delegates

extension SelectedClassViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.classDetail == nil{
            return 3
        }
        else{
            return dataArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassOptionsCell", for: indexPath) as! CoursesCollectionViewCell
        if viewModel.classDetail == nil{
            cell.indicatorView.isHidden = true
            cell.contentView.showAnimatedSkeleton()
        }
        else{
            cell.contentView.hideSkeleton()
            cell.optionLbl.text = dataArray[indexPath.row]
            
            if (isMyClass && selectedIndex == indexPath.row) || (!isMyClass && selectedIndex == indexPath.row + 1){
                cell.optionLbl.textColor = .black
                if UIDevice.current.userInterfaceIdiom == .pad{
                    cell.optionLbl.font = UIFont(name: "Asap-SemiBold", size: 24)
                }
                else{
                    cell.optionLbl.font = UIFont(name: "Asap-SemiBold", size: 14)
                }
                cell.indicatorView.isHidden = false
            }
            else{
                cell.optionLbl.textColor = UIColor(named: "AppLightGray")
                if UIDevice.current.userInterfaceIdiom == .pad{
                    cell.optionLbl.font = UIFont(name: "Asap-Medium", size: 24)
                }
                else{
                    cell.optionLbl.font = UIFont(name: "Asap-Medium", size: 14)
                }
               
                cell.indicatorView.isHidden = true
            }
        }
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isMyClass{
            self.selectedIndex = indexPath.row
        }
        else{
            self.selectedIndex = indexPath.row + 1
        }
        setBottomView()
        collectionView.reloadData()
        classTableView.reloadData()
     //   updateTableHeight(tableName: classTableView, tableHeight: tableHeight)
        
        if tableHeight.constant < 10{
            //selectedIndex == 2{
            tableHeight.constant = 100
        }
        classTableView.reloadData()
        
    }
    
}

//MARK: - UITableView Delegate

//extension SelectedClassViewController: UITableViewDelegate, UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        switch selectedIndex {
//
//        case 0:
//
//            if courseViewModel.messages.count == 0{
//
//                tableCollectionErrors(view: tableView, text: "Start a conversation", headerHeight: 0)
//            }
//            else{
//                tableCollectionErrors(view: tableView, text: "", headerHeight: 0)
//            }
//
//            return courseViewModel.messages.count
//
//        case 1:
//            tableCollectionErrors(view: classTableView, text: "", headerHeight: 0)
//
//
//            return 1
//
//        case 2:
//
//            setBottomView()
//
//            if (viewModel.classDetail?.studyMaterial?.count ?? 0) == 0{
//                showAllMaterial = true
//                tableHeight.constant = 100
//                tableCollectionErrors(view: classTableView, text: "No material available", headerHeight: 0)
//            }
//            else if (viewModel.classDetail?.studyMaterial?.count ?? 0) <= 10{
//                showAllMaterial = true
//                tableCollectionErrors(view: classTableView, text: "", headerHeight: 0)
//            }
//            else{
//                tableCollectionErrors(view: classTableView, text: "", headerHeight: 0)
//            }
//
//            if showAllMaterial{
//                return viewModel.classDetail?.studyMaterial?.count ?? 0
//            }
//            else{
//                moreAvailableBtn.setTitle("\((viewModel.classDetail?.studyMaterial?.count ?? 0) - 10) More Available", for: .normal)
//                return 10
//            }
//
//
//
//        case 3:
//            tableCollectionErrors(view: classTableView, text: "", headerHeight: 0)
//            return viewModel.moreDataArray.count
//
//        default:
//            return 1
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        switch selectedIndex {
//
//        case 0:
//
//            let model = courseViewModel.messages[indexPath.row]
//            let currentDate = Date().string(format: "yyyy-MM-dd")
//            let messageDate = model.createdAt ?? ""
//            let mesageFormattedDate = Singleton.sharedInstance.changeDateFormat(date: messageDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
//            let messageTime = Singleton.sharedInstance.changeDateFormat(date: messageDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "HH:mm a")
//            var previousDate = ""
//
//            if indexPath.row > 0{
//                previousDate = Singleton.sharedInstance.changeDateFormat(date: courseViewModel.messages[indexPath.row - 1].createdAt ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
//            }
//
//            if model.userID?.id ?? 0 != UserDefault.sharedInstance?.getUserDetails()?.id ?? 0{
//
//                if model.attachment != nil{
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "receiveMediaCell") as! ChatTableViewCell
//
//                    cell.messageLbl.text = model.message ?? ""
//
//                    if mesageFormattedDate == previousDate{
//                        cell.messageDateView.isHidden = true
//                    }
//                    else{
//                        cell.messageDateView.isHidden = false
//                        cell.messageDateLbl.text = Singleton.sharedInstance.changeDateFormat(date: messageDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
//                    }
//                    cell.messageTimeLbl.text = messageTime
//                    cell.usernameaLbl.text = (model.userID?.name ?? "").capitalized
//
//                    //Check whether the user is a tutor or not. If tutor then highlight the name.
//
//                    if (self.viewModel.classDetail?.teacher?.id ?? 0) == (model.userID?.id ?? 0){
//                        cell.usernameaLbl.font = UIFont(name: "Asap-SemiBold", size: cell.usernameaLbl.font.pointSize)
//                        cell.usernameaLbl.textColor = UIColor(named: "AppBlack")
//                    }
//                    else{
//                        cell.usernameaLbl.font = UIFont(name: "Asap-Medium", size: cell.usernameaLbl.font.pointSize)
//                        cell.usernameaLbl.textColor = UIColor(named: "AppDarkGray")
//                    }
//
//                    cell.mediaImageView.sd_setImage(with: URL(string: model.attachment ?? ""), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
//
//                    return cell
//                }
//                else{
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "receiveCell") as! ChatTableViewCell
//
//                    cell.messageLbl.text = model.message ?? ""
//
//                    if mesageFormattedDate == previousDate{
//                        cell.messageDateView.isHidden = true
//                    }
//                    else{
//                        cell.messageDateView.isHidden = false
//                        cell.messageDateLbl.text = Singleton.sharedInstance.changeDateFormat(date: messageDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
//                    }
//                    cell.messageTimeLbl.text = messageTime
//                    cell.usernameaLbl.text = (model.userID?.name ?? "").capitalized
//
//                    //Check whether the user is a tutor or not. If tutor then highlight the name.
//
//                    if (self.viewModel.classDetail?.teacher?.id ?? 0) == (model.userID?.id ?? 0){
//                        cell.usernameaLbl.font = UIFont(name: "Asap-SemiBold", size: cell.usernameaLbl.font.pointSize)
//                        cell.usernameaLbl.textColor = UIColor(named: "AppBlack")
//                    }
//                    else{
//                        cell.usernameaLbl.font = UIFont(name: "Asap-Medium", size: cell.usernameaLbl.font.pointSize)
//                        cell.usernameaLbl.textColor = UIColor(named: "AppDarkGray")
//                    }
//
//                    return cell
//                }
//
//            }
//            else{
//
//                if let attachment = model.attachment{
//
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "sendMediaCell") as! ChatTableViewCell
//
//                    let model = courseViewModel.messages[indexPath.row]
//
//                    cell.messageLbl.text = model.message ?? ""
//
//                    if mesageFormattedDate == previousDate{
//                        cell.messageDateView.isHidden = true
//                    }
//                    else{
//                        cell.messageDateView.isHidden = false
//                        cell.messageDateLbl.text = Singleton.sharedInstance.changeDateFormat(date: messageDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
//                    }
//                    cell.messageTimeLbl.text = messageTime
//                    cell.usernameaLbl.text = (model.userID?.name ?? "").capitalized
//                    cell.mediaImageView.sd_setImage(with: URL(string: attachment), placeholderImage: UIImage(named: "placeholderImage"), options: .highPriority, context: nil)
//                    return cell
//                }
//                else{
//
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "sendCell") as! ChatTableViewCell
//
//                    let model = courseViewModel.messages[indexPath.row]
//
//                    cell.messageLbl.text = model.message ?? ""
//
//                    if mesageFormattedDate == previousDate{
//                        cell.messageDateView.isHidden = true
//                    }
//                    else{
//                        cell.messageDateView.isHidden = false
//                        cell.messageDateLbl.text = Singleton.sharedInstance.changeDateFormat(date: messageDate, fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
//                    }
//                    cell.messageTimeLbl.text = messageTime
//                    cell.usernameaLbl.text = (model.userID?.name ?? "").capitalized
//                    return cell
//                }
//
//            }
//
//
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "classDescription") as! mockTestTableViewCell
//            if viewModel.classDetail == nil{
//                cell.contentView.showAnimatedSkeleton()
//            }
//            else{
//                cell.contentView.hideSkeleton()
//                cell.overViewLbl.text = (viewModel.classDetail?.content ?? "").html2String
//            }
//            return cell
//
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "mockTestTableViewCell") as! mockTestTableViewCell
//            cell.testTile.text = viewModel.classDetail?.studyMaterial?[indexPath.row].title ?? ""
//            cell.mainBackgroundView.EnableShadow = true
//            if isMyClass{
//                //viewModel.classDetail?.studyMaterial?[indexPath.row].type ?? 0 == 0{
//                cell.lockImage.isHidden = true
//            }
//            else{
//                cell.lockImage.isHidden = false
//            }
//            cell.goForwardBtn.isUserInteractionEnabled = true
//            cell.goForwardBtn.tag = indexPath.row
//            cell.goForwardBtn.addTarget(self, action: #selector(downloadStudyMaterial(sender:)), for: .touchUpInside)
//            return cell
//
//        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "moreOptions") as! mockTestTableViewCell
//            cell.optionLbl.text = viewModel.moreDataArray[indexPath.row].viewName
//            cell.optionImage.image = viewModel.moreDataArray[indexPath.row].image
//            cell.favouriteBtn.tag = indexPath.row
//            cell.favouriteBtn.addTarget(self, action: #selector(tapFavourite(_:)), for: .touchUpInside)
//            if indexPath.row == 1{
//
//                if isFavourite{
//                    cell.optionImage.image = UIImage(named: "favouriteRoundIcon")
//                    cell.optionLbl.text = "Unfavourite"
//                }
//                else{
//                    cell.optionImage.image = UIImage(named: "UnfavouriteIcon")
//                    cell.optionLbl.text = viewModel.moreDataArray[indexPath.row].viewName
//                }
//
//            }
//            return cell
//
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "classDescription") as! mockTestTableViewCell
//            return cell
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        switch selectedIndex{
//        case 0:
//            break
//
//        case 1:
//            break
//
//        case 2:
//
//            if !isMyClass{
//                //viewModel.classDetail?.studyMaterial?[indexPath.row].type ?? 0 == 1 || UserDefault.sharedInstance?.getUserDetails()?.id == nil{
//                self.showToast(message: "Please purchase this course to view this study material")
//            }
//            else{
//                let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "PDFViewController") as! PDFViewController
//                vc.fileUrl = URL(string: viewModel.classDetail?.studyMaterial?[indexPath.row].material ?? "")
//                vc.modalPresentationStyle = .overFullScreen
//                self.present(vc, animated: true, completion: nil)
//            }
//
//            break
//
//        case 3:
//            moreTabRow(indexPath: indexPath)
//        default:
//            break
//        }
//    }
//
//}

//MARK: - DocumentPicker Delegates

//extension SelectedClassViewController:DocumentPickerDelegate{
//
//    func selectedDocxData(fileData: Data?, fileType: String?) {
//
//        if let data = fileData, let type = fileType{
//            print("Fetched Data = \(data), \(type)")
//
//            let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "ChatCaptionViewController") as! ChatCaptionViewController
//            vc.fileData = data
//            vc.mediaType = type
//
//            vc.cb = {
//                selectedData,message in
//                self.fileName = generateUniqueName(withSuffix: type)
//                self.fileData = data
//                self.fileType = type
//
//                self.sendMessage(message: message ?? "", fileData: data, fileType: type, fileName: generateUniqueName(withSuffix: type))
//            }
//            vc.modalPresentationStyle = .overCurrentContext
//            self.navigationController?.present(vc, animated: true, completion: nil)
//        }
//        else{
//            print("Error in fetching documents")
//        }
//    }
//
//
//}

//MARK: - ImagePicker Delegates

//extension SelectedClassViewController:ImagePickerDelegate{
//
//    func didSelect(Mediadata: Data?, uploadType: whatToUpload?) {
//
//        if let data = Mediadata, let type = uploadType{
//
//            var typeString = ""
//
//            switch type {
//
//            case .photo:
//               typeString = ".jpeg"
//
//            case .audio:
//                typeString = ".m4a"
//
//            case .video:
//                typeString = ".mp4"
//
//            default:
//                break
//            }
//            //attachmentBtn.setImage(UIImage(named: "redCross"), for: .normal)
//
//            let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "ChatCaptionViewController") as! ChatCaptionViewController
//            vc.fileData = data
//            vc.mediaType = typeString
//
//            vc.cb = {
//                selectedData,message in
//                self.fileName = generateUniqueName(withSuffix: typeString)
//                self.fileData = data
//                self.fileType = typeString
//
//                self.sendMessage(message: message ?? "", fileData: data, fileType: typeString, fileName: generateUniqueName(withSuffix: typeString))
//            }
//            vc.modalPresentationStyle = .overCurrentContext
//            self.navigationController?.present(vc, animated: true, completion: nil)
//
//        }
//    }
//}

//MARK: - api call

extension SelectedClassViewController{
    
    func getClassDetail(){
        viewModel.classDetailsApi(classId: classId, completion: {(isSuccess, message) in
            if isSuccess{
                self.setData()
            }
            else{
                self.showToast(message: message)
            }
        })
    }
    
//    func favouriteClass(){
//        viewModel.favourites(online_class_id: classId, completion: {(isSuccess, message) in
//            if isSuccess{
//                self.isFavourite = !self.isFavourite
//                self.classTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
//
//            }
//            else{
//                self.showToast(message: message)
//            }
//        })
//    }
//
//    func messagesList(){
//
//        Indicator.shared.showProgressView(self.view)
//
//        courseViewModel.getMessages(course_id: classId,isOnlineClass:true,completion: {(isSuccess, msg) in
//
//            Indicator.shared.hideProgressView()
//
//            if isSuccess{
//
//                self.classTableView.reloadData()
//                self.classTableView.reloadData()
//
//                self.updateTableHeight(tableName: self.classTableView, tableHeight: self.tableHeight)
//                self.updateTableHeight(tableName: self.classTableView, tableHeight: self.tableHeight)
//                self.updateTableHeight(tableName: self.classTableView, tableHeight: self.tableHeight)
//
//                if self.tableHeight.constant < 1{
//                    self.tableHeight.constant = 100
//                }
//
//
//                self.classTableView.scrollToBottom(animated: false)
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    self.mainScrollView.scrollViewToBottom(animated: true)
//                }
//
//            }
//            else{
//                self.showToast(message: msg)
//            }
//
//        })
//    }
    
//    func sendMessage(message:String,fileData:Data? = nil, fileType:String? = nil , fileName:String? = nil){
//
//        Indicator.shared.showProgressView(self.view)
//
//        courseViewModel.postMessages(course_id: classId,tutorId:"",messageToSend: message, isOnlineClass:true,fileName: fileName,fileType: fileType,fileData: fileData , completion: {(isSuccess, msg) in
//
//            Indicator.shared.hideProgressView()
//
//            if isSuccess{
//                self.messageTxtView.text = ""
//                self.setBottomView()
//                self.updateTableHeight(tableName: self.classTableView, tableHeight: self.tableHeight)
//                self.updateTableHeight(tableName: self.classTableView, tableHeight: self.tableHeight)
//                self.classTableView.reloadData()
//                self.classTableView.scrollToBottom(animated: false)
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    self.mainScrollView.scrollViewToBottom(animated: true)
//                }
//            }
//            else{
//                self.showToast(message: msg)
//            }
//
//        })
//    }
    
}
