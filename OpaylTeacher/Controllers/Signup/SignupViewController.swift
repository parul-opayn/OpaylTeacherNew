//
//  SignupViewController.swift
//  IletsLearning
//
//  Created by OPAYN on 25/10/21.
//

import UIKit
import GrowingTextView

class SignupViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var fullnameTxtFld: RoundTextField!
    @IBOutlet weak var emailTxtFld: RoundTextField!
    @IBOutlet weak var passwordTxtFld: RoundTextField!
    @IBOutlet weak var confirmPasswordTxtFld: RoundTextField!
    @IBOutlet weak var AboutTxtView: GrowingTextView!
    @IBOutlet weak var documentsCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var documentsCollectionview: UICollectionView!
    @IBOutlet weak var documentsTopBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var documentTopConstraint: NSLayoutConstraint!
    
    
    //DropDown Outlets
    
    @IBOutlet weak var servicesView: SetView!
    @IBOutlet weak var servicesTxtfld: SetTextField!
    @IBOutlet weak var servicesBtn: SetButton!
    @IBOutlet weak var servicesTableView: UITableView!
    @IBOutlet weak var servicesTabHeight: NSLayoutConstraint!
    @IBOutlet weak var servicesUnderline: UIView!

    
    @IBOutlet weak var QualificationsView: SetView!
    @IBOutlet weak var qualificationsTxtfld: SetTextField!
    @IBOutlet weak var qualificationsBtn: SetButton!
    @IBOutlet weak var qualificationsTableview: UITableView!
    @IBOutlet weak var qualificationsTableHeight: NSLayoutConstraint!
    @IBOutlet weak var qualificationsUnderline: UIView!
    @IBOutlet weak var userProfileImage: SetImage!
    //
//    @IBOutlet weak var levelView: SetView!
//    @IBOutlet weak var levelTxtfld: SetTextField!
//    @IBOutlet weak var levelBtn: SetButton!
//    @IBOutlet weak var levelTableView: UITableView!
//    @IBOutlet weak var levelTabHeight: NSLayoutConstraint!
//    @IBOutlet weak var levelUnderline: UIView!
    
    //MARK: - Variables
    
    var viewModel = SignupViewModel()
    var selectedProfession = -1
    var selectedCourses = [Int]()
    var selectedLevel = -1
    var walkThroughData: WalkThroughDataModel?
    var isIPad = false
    var documents = [UIImage]()
    var docPicker: DocumentPicker?
    var photosPicker: ImagePicker?
    var selectedData = [Int]()
    var imageFor:displayImageFor = .profile
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        servicesTableView.isHidden = true
        servicesTabHeight.constant = 0
        servicesTableView.tableFooterView = UIView()
        servicesUnderline.isHidden = true
        servicesTableView.delegate = self
        servicesTableView.dataSource = self

        qualificationsTableview.isHidden = true
        qualificationsTableHeight.constant = 0
        qualificationsTableview.tableFooterView = UIView()
        qualificationsTableview.delegate = self
        qualificationsTableview.dataSource = self
        qualificationsUnderline.isHidden = true
        qualificationsTableview.allowsMultipleSelection = true
        
        documentsCollectionHeight.constant = 0
        documentsCollectionview.delegate = self
        documentsCollectionview.dataSource = self
        documentsTopBottomConstraint.constant = 0
        documentTopConstraint.constant = 16
        
        docPicker = DocumentPicker(showOnViewController: self, delegate: self)
        photosPicker = ImagePicker(presentationController: self, delegate: self)
        
        if UIDevice().userInterfaceIdiom == .pad{
            isIPad = true
        }
        else{
            isIPad = false
        }
        //addBorderToTextView()
        documentsCollectionHeight.constant = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationWithBack(navtTitle: "", titleType: .large, titleColor: .black)
        navigationButtonsDelegate = self
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationButtonsDelegate = nil
    }
    
    //MARK: - Custom Methods
    
    func addBorderToTextView(){
        AboutTxtView.layer.borderColor = UIColor(named: "AppLightPink")?.cgColor
        AboutTxtView.layer.borderWidth = 1
        AboutTxtView.layer.cornerRadius = 10
    }
    
    func displayPreviouslySelectedRows(){
        
        for index in self.selectedData{
            self.qualificationsTableview.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .bottom)
        }
        
    }
    
    func selectDeselectRow(tableView:UITableView,indexpath:[IndexPath]?){
        
        var selectedValues = [String]()
        selectedData.removeAll()
        
        if let indexpaths = indexpath{
           
            for index in indexpaths{
                selectedData.append(index.row)
                selectedValues.append("MBA")
                print(index)
            }
            self.qualificationsTxtfld.text = selectedValues.joined(separator: ", ")
        }
        else{
            self.qualificationsTxtfld.text = ""
        }
    }
    
    
    //MARK: - Objc Methods
    
    @objc func didTapDeleteBtn(sender:UIButton){
        self.documents.remove(at: sender.tag)
        if documents.count == 0{
            self.documentsCollectionHeight.constant = 0
            documentsTopBottomConstraint.constant = 0
            documentTopConstraint.constant = 16
        }
        else{
            documentsTopBottomConstraint.constant = 16
            documentTopConstraint.constant = 16
            self.documentsCollectionHeight.constant = 100
        }
       
        self.documentsCollectionview.reloadData()
    }
    
    //MARK: - IBActions
    
    @IBAction func tappedSignupBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        let validation = viewModel.validations(name: fullnameTxtFld.text ?? "", email: emailTxtFld.text ?? "", password: passwordTxtFld.text ?? "", confirmPassword: confirmPasswordTxtFld.text ?? "")
        if validation.0{
            signupApi()
        }
        else{
            self.showToast(message: validation.1)
        }
    }
    
    @IBAction func tappedLoginBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
//        let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func tappedservicesBtn(_ sender: Any) {

        servicesTableView.isHidden = !servicesTableView.isHidden

        if servicesTableView.isHidden{
            
            servicesTabHeight.constant = 0

            if isIPad{
                servicesBtn.setImage(UIImage(named: "downArrow-iPad"), for: .normal)
            }
            else{
                servicesBtn.setImage(UIImage(named: "downArrow"), for: .normal)
            }

            servicesView.EnableShadow = false
          //  servicesView.ShadowOpacity = 0
            servicesUnderline.isHidden = true
        }
        else{
            updateTableHeight(tableName: servicesTableView, tableHeight: servicesTabHeight)

            if isIPad{
                servicesBtn.setImage(UIImage(named: "upArrow-iPad"), for: .normal)
            }
            else{
                servicesBtn.setImage(UIImage(named: "upArrow"), for: .normal)
            }

            servicesView.EnableShadow = true
            servicesUnderline.isHidden = false
           // servicesView.ShadowOpacity = 1
        }
    }
//
//
    @IBAction func tappedqualificationsBtn(_ sender: UIButton) {

        qualificationsTableview.isHidden = !qualificationsTableview.isHidden

        if qualificationsTableview.isHidden{
            qualificationsTableHeight.constant = 0

            if isIPad{
                qualificationsBtn.setImage(UIImage(named: "downArrow-iPad"), for: .normal)
            }
            else{
                qualificationsBtn.setImage(UIImage(named: "downArrow"), for: .normal)
            }

            QualificationsView.EnableShadow = false
           // QualificationsView.ShadowOpacity = 0
            qualificationsUnderline.isHidden = true
        }
        else{
            updateTableHeight(tableName: qualificationsTableview, tableHeight: qualificationsTableHeight)
            self.displayPreviouslySelectedRows()
//            qualificationsBtn.setImage(UIImage(named: "upArrow"), for: .normal)
            if isIPad{
                qualificationsBtn.setImage(UIImage(named: "upArrow-iPad"), for: .normal)
            }
            else{
                qualificationsBtn.setImage(UIImage(named: "upArrow"), for: .normal)
            }
            QualificationsView.EnableShadow = true
            qualificationsUnderline.isHidden = false
           // QualificationsView.ShadowOpacity = 1
        }
    }
    
    @IBAction func tappedUploadDocuments(_ sender: UIButton) {
        
        self.imageFor = .documents
        
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
    }
    
    
    @IBAction func tappedCameraBtn(_ sender: UIButton) {
        self.photosPicker?.media = .photosGalleryAndCamera
        self.photosPicker?.upload = .photo
        //self.photosPicker?.displayActionSheet = false
        self.imageFor = .profile
        self.photosPicker?.showPickerAlert(view: self.view)
    }
    
    
//
//    @IBAction func tappedLevelBtn(_ sender: UIButton) {
//
//        levelTableView.isHidden = !levelTableView.isHidden
//
//        if levelTableView.isHidden{
//            levelTabHeight.constant = 0
//
//            if isIPad{
//                levelBtn.setImage(UIImage(named: "downArrow-iPad"), for: .normal)
//            }
//            else{
//                levelBtn.setImage(UIImage(named: "downArrow"), for: .normal)
//            }
//
//            levelView.EnableShadow = false
//            levelUnderline.isHidden = true
//            //levelView.ShadowOpacity = 0
//        }
//        else{
//            updateTableHeight(tableName: levelTableView, tableHeight: levelTabHeight)
////            levelBtn.setImage(UIImage(named: "upArrow"), for: .normal)
//            if isIPad{
//                levelBtn.setImage(UIImage(named: "upArrow-iPad"), for: .normal)
//            }
//            else{
//                levelBtn.setImage(UIImage(named: "upArrow"), for: .normal)
//            }
//            levelView.EnableShadow = true
//            levelUnderline.isHidden = false
//            //levelView.ShadowOpacity = 1
//        }
//
//    }
    
    
    
}

//MARK: - Tableview Delegates

extension SignupViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == servicesTableView{
            return 10
        }
        else{
           return 10
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == servicesTableView{

            let cell = tableView.dequeueReusableCell(withIdentifier: "professionCell") as! BankNameTableViewCell
            cell.labelName.text = "IELTS" //(walkThroughData?.userCategory?[indexPath.row].name ?? "").capitalized
            
            if indexPath.row == 9{
                cell.SeperatorLine.isHidden = true
            }
            else{
                cell.SeperatorLine.isHidden = false
            }
            cell.isMultipleSelection = false
            return cell

        }
        else if tableView == qualificationsTableview{

            let cell = tableView.dequeueReusableCell(withIdentifier: "PreparationCell") as! BankNameTableViewCell
            cell.labelName.text = "MBA" //(walkThroughData?.services?[indexPath.row].name ?? "").capitalized
            cell.isMultipleSelection = true
//            if selectedCourses.contains(walkThroughData?.services?[indexPath.row].id ?? 0){
//                cell.checkBoxImage.image = UIImage(named: "checkBox")
//            }else{
//                cell.checkBoxImage.image = UIImage(named: "uncheckBox")
//            }
//            if indexPath.row == (walkThroughData?.services?.count ?? 0) - 1{
//                cell.SeperatorLine.isHidden = true
//            }else{
//                cell.SeperatorLine.isHidden = false
//            }
            return cell

        }
        else{

            let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell") as! BankNameTableViewCell
            cell.labelName.text = (walkThroughData?.levels?[indexPath.row].name ?? "").capitalized
            if indexPath.row == (walkThroughData?.levels?.count ?? 0) - 1{
                cell.SeperatorLine.isHidden = true
            }else{
                cell.SeperatorLine.isHidden = false
            }
            return cell

        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == servicesTableView{
           
           
           // servicesTxtfld.text = ""
            servicesTableView.isHidden = true
            servicesUnderline.isHidden = true
            servicesTabHeight.constant = 0

            if isIPad{
                servicesBtn.setImage(UIImage(named: "downArrow-iPad"), for: .normal)
            }
            else{
                servicesBtn.setImage(UIImage(named: "downArrow"), for: .normal)
            }

            servicesView.EnableShadow = false
            
        }
        
        else{
            print("Qualification Selected")
            selectDeselectRow(tableView: tableView, indexpath:  tableView.indexPathsForSelectedRows)
        }
       //

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == qualificationsTableview{
            selectDeselectRow(tableView: tableView, indexpath:  tableView.indexPathsForSelectedRows)
        }
    }
}

//MARK: - UICollectionview Delegates/Datasources

extension SignupViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocumentsCollectionViewCell", for: indexPath) as! DocumentsCollectionViewCell
        cell.documentPreviewImage.image = documents[indexPath.row]
        cell.deleteImageBtn.tag = indexPath.row
        cell.deleteImageBtn.addTarget(self, action: #selector(didTapDeleteBtn), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2.3 - 8, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

//MARK: - DocumentPicker Delegates

extension SignupViewController:DocumentPickerDelegate{
   
    func selectedDocxData(fileData: Data?, fileType: String?) {
        
        if let data = fileData, let type = fileType{
            
            switch type {
            
            case "docx":
                documents.append(UIImage(named: "my course-active") ?? UIImage())
                
            case "pdf":
                documents.append(UIImage(named: "my course-active") ?? UIImage())
                
            case ".jpeg":
                documents.append(UIImage(data: data) ?? UIImage())
                
            default:
                documents.append(UIImage(named: "my course-active") ?? UIImage())
            }
            
            self.documentsTopBottomConstraint.constant = 16
            self.documentsCollectionHeight.constant = 100
            documentsCollectionview.reloadData()
        }
        else{
            print("Error in fetching documents")
        }
    }
    
    
}

//MARK: - ImagePicker Delegates

extension SignupViewController:ImagePickerDelegate{
   
    func didSelect(Mediadata: Data?, uploadType: whatToUpload?) {
       
        if let data = Mediadata, let type = uploadType{
            
            var typeString = ""
            
            switch type {
           
            case .photo:
               typeString = ".jpeg"
                
            case .audio:
                typeString = ".m4a"
                
            case .video:
                typeString = ".mp4"
                
            default:
                break
            }
            
            if imageFor == .documents{
                documents.append(UIImage(data: data) ?? UIImage())
                self.documentsTopBottomConstraint.constant = 16
                documentTopConstraint.constant = 16
                self.documentsCollectionHeight.constant = 100
                documentsCollectionview.reloadData()
                documentsCollectionview.reloadData()
            }
            else{
                self.userProfileImage.image = UIImage(data: data) ?? UIImage()
            }
            
        }
    }
}

//MARK: - API Calls

extension SignupViewController{
    
    func signupApi(){
        
        Indicator.shared.showProgressView(self.view)
        
        var coursesId = [String]()
        for i in 0..<selectedCourses.count{
            coursesId.append("\(selectedCourses[i])")
        }
        viewModel.signup(name: fullnameTxtFld.text ?? "", email: emailTxtFld.text ?? "", password: passwordTxtFld.text ?? "", user_category: "\(selectedProfession)", services: coursesId, course_level: "\(selectedLevel)") { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
                self.showToast(message: "Please Verify your email.")
                let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "PasscodeViewController") as! PasscodeViewController
                vc.displayFor = .signup
                vc.id = "\(UserDefault.sharedInstance?.getUserDetails()?.id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
                UserDefaults.standard.set(self.selectedProfession, forKey: "UserProfessionId")
                UserDefaults.standard.set(self.selectedCourses, forKey: "UserCoursesId")
                UserDefaults.standard.set(self.selectedLevel, forKey: "UserEnglishLevel")
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}

//MARK: - Navigation Delegates

extension SignupViewController: customNavigationDelegates{
    
    func didTapRightButton(buttonType type: rightButtontype) {
        
    }
    
    func didTapLeftbutton(buttonType type: LeftButtonType) {
      
        if type == .back{
            print("user has moved back from signup. Removing cached data to remove any inappropriate behaviour")
            UserDefault.sharedInstance?.removeUserData()
            UserDefault.sharedInstance?.updateUserData()
        }
    }
    
}

//MARK: - Enums

extension SignupViewController{
  
    enum displayImageFor {
        case profile
        case documents
    }
    
}
