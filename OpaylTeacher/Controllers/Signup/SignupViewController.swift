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
    @IBOutlet weak var mobileTextField: RoundTextField!
    @IBOutlet weak var experienceTxtFld: RoundTextField!
    @IBOutlet weak var confirmPasswordTxtFld: RoundTextField!
    @IBOutlet weak var AboutTxtView: GrowingTextView!
    @IBOutlet weak var introductionTxtFld: RoundTextField!
    @IBOutlet weak var documentsCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var documentsCollectionview: UICollectionView!
    @IBOutlet weak var documentsTopBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var documentTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var documentsView: SetView!
    @IBOutlet weak var loginNavigationView: UIView!
    @IBOutlet weak var passwordFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var servicesTop: NSLayoutConstraint!
    @IBOutlet weak var qualificationsTop: NSLayoutConstraint!
    @IBOutlet weak var documentsTop: NSLayoutConstraint!
    @IBOutlet weak var introTop: NSLayoutConstraint!
    @IBOutlet weak var uploadDocumentsLblTop: NSLayoutConstraint!
    @IBOutlet weak var signupBtn: SetButton!
    
    
    //DropDown Outlets
    
    @IBOutlet weak var servicesView: SetView!
    @IBOutlet weak var servicesTxtfld: SetTextField!
    @IBOutlet weak var servicesBtn: SetButton!
    @IBOutlet weak var servicesTableView: UITableView!
    @IBOutlet weak var servicesTabHeight: NSLayoutConstraint!
    @IBOutlet weak var servicesUnderline: UIView!
    @IBOutlet weak var serviceBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var qualificationBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var documentsBtnHeight: NSLayoutConstraint!
    
    @IBOutlet weak var QualificationsView: SetView!
    @IBOutlet weak var qualificationsTxtfld: SetTextField!
    @IBOutlet weak var qualificationsBtn: SetButton!
    @IBOutlet weak var qualificationsTableview: UITableView!
    @IBOutlet weak var qualificationsTableHeight: NSLayoutConstraint!
    @IBOutlet weak var qualificationsUnderline: UIView!
    @IBOutlet weak var userProfileImage: SetImage!
    @IBOutlet weak var mainHeadingLbl: UILabel!

    
    //MARK: - Variables
    
    var viewModel = SignupViewModel()
    var selectedProfession = -1
    var selectedCourses = [Int]()
    var selectedLevel = -1
//    var walkThroughData: WalkThroughDataModel?
    var isIPad = false
    var documents = [UIImage]()
    var docPicker: DocumentPicker?
    var photosPicker: ImagePicker?
    var selectedData = [Int]()
    var imageFor:displayImageFor = .profile
    var isEdit:Bool = false
    
    //MARK: - Variables for uploading documents
    
    var fileName = [String]()
    var fileData = [Data]()
    var fileType = [String]()
    var fileParam = [String]()
    
    var editFileName = String()
    var editFileData = Data()
    var editFileType = String()
    var editFileParam = String()
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        servicesTableView.isHidden = true
        servicesTabHeight.constant = 0
        servicesTableView.tableFooterView = UIView()
        servicesUnderline.isHidden = true
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        servicesTableView.allowsMultipleSelection = true
        
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
        servicesListing()
        qualificationsListing()
        
        if isEdit{
            mainHeadingLbl.text = "Edit Profile"
            editProfileData()
        }
        
        introductionTxtFld.delegate = self
        passwordTxtFld.delegate = self
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
    
    func editProfileData(){
        
        let model = UserDefault.sharedInstance?.getUserDetails()
        
        fullnameTxtFld.text = model?.name ?? ""
        emailTxtFld.text = model?.email ?? ""
        mobileTextField.text = model?.contactNumber ?? ""
        experienceTxtFld.text = "\(model?.experience?.Value ?? "0")"
        passwordTxtFld.isHidden = true
        emailTxtFld.isUserInteractionEnabled = false
        introductionTxtFld.text = model?.introduction ?? ""
        AboutTxtView.text = model?.loginModelDescription ?? ""
        servicesView.isHidden = true
        serviceBtnHeight.constant = 0
        servicesTabHeight.constant = 0
        servicesTop.constant = 0
        
        QualificationsView.isHidden = true
        qualificationsTableHeight.constant = 0
        qualificationBtnHeight.constant = 0
        qualificationsTop.constant = 0
        
        documentsBtnHeight.constant = 0
        documentsCollectionHeight.constant = 0
        documentsView.isHidden = true
        documentsTop.constant = 0
        uploadDocumentsLblTop.constant = 0
        documentsTopBottomConstraint.constant = 0
        introTop.constant = 0
        
        userProfileImage.sd_setImage(with: URL(string: model?.image ?? ""), placeholderImage: UIImage(named: "user-white"), options: .highPriority, context: nil)
        loginNavigationView.isHidden = true
        signupBtn.setTitle("Edit Profile", for: .normal)
    }
    
    func displayPreviouslySelectedRows(){
        
        for index in self.viewModel.teacherQualifications.indices{
            
            if self.viewModel.teacherQualifications[index].isSelected ?? false{
                self.qualificationsTableview.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .bottom)
            }
            
        }
        
    }
    
    func displayPreviouslySelectedServices(){
        
        for index in self.viewModel.teacherServices.indices{
            
            if self.viewModel.teacherServices[index].isSelected ?? false{
                self.servicesTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .bottom)
            }
            
        }
        
    }
    
    func selectDeselectRow(tableView:UITableView,indexpath:[IndexPath]?){
        
        if tableView == servicesTableView{
            for i in viewModel.teacherServices.indices{
                viewModel.teacherServices[i].isSelected = nil
            }
            
            if let indexpaths = indexpath{
                
                for index in indexpaths{
                    viewModel.teacherServices[index.row].isSelected = true
                    print(index)
                }
                self.servicesTxtfld.text = (viewModel.teacherServices.filter({$0.isSelected ?? false}).map{$0.name ?? ""}).joined(separator: ", ")
            }
            else{
                self.servicesTxtfld.text = ""
            }
        }
        else{
            
            //Remove all previous selections
            
            for i in viewModel.teacherQualifications.indices{
                viewModel.teacherQualifications[i].isSelected = nil
            }
            
            if let indexpaths = indexpath{
                
                for index in indexpaths{
                    viewModel.teacherQualifications[index.row].isSelected = true
                    print(index)
                }
                self.qualificationsTxtfld.text = (viewModel.teacherQualifications.filter({$0.isSelected ?? false}).map{$0.title ?? ""}).joined(separator: ", ")
            }
            else{
                self.qualificationsTxtfld.text = ""
            }
        }
        
    }
    
    
    //MARK: - Objc Methods
    
    @objc func didTapDeleteBtn(sender:UIButton){
        
        self.documents.remove(at: sender.tag)
        self.fileName.remove(at: sender.tag)
        self.fileType.remove(at: sender.tag)
        self.fileData.remove(at: sender.tag)
        self.fileParam.remove(at: sender.tag)
        
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
        
        var selectedProfile = false
        
        if userProfileImage.image == UIImage(named: "user-white"){
            selectedProfile = false
        }
        else{
            selectedProfile = true
        }
        
        if !isEdit{
           
            let validation = viewModel.validations(uploadedProfileImage: selectedProfile, name: fullnameTxtFld.text ?? "", email: emailTxtFld.text ?? "", mobile: mobileTextField.text ?? "", experience: experienceTxtFld.text ?? "", password: passwordTxtFld.text ?? "", servicesCount: viewModel.teacherServices.filter({$0.isSelected ?? false}).count, qualificationsCount:  viewModel.teacherQualifications.filter({$0.isSelected ?? false}).count, documentsCount: documents.count, intro: introductionTxtFld.text ?? "", about: AboutTxtView.text ?? "")
            
            if validation.0{
                signupApi()
            }
            else{
                self.showToast(message: validation.1)
            }
        }
        else{
            
            let validation = viewModel.editValidations(uploadedProfileImage: selectedProfile, name: fullnameTxtFld.text ?? "", email: emailTxtFld.text ?? "", mobile: mobileTextField.text ?? "", experience: experienceTxtFld.text ?? "", intro: introductionTxtFld.text ?? "", about: AboutTxtView.text ?? "")
            if validation.0{
                
                if editFileName == ""{
                    let name = (UserDefault.sharedInstance?.getUserDetails()?.image ?? "").components(separatedBy: "/").last
                    self.editFileName = name ?? generateUniqueName(withSuffix: ".jpg")
                    self.editFileData = userProfileImage.image?.jpegData(compressionQuality: 1.0) ?? Data()
                    self.editFileType = "image/jpeg"
                    self.editFileParam = "profile"
                }
             
                self.editProfileApi()
            }
            else{
                self.showToast(message: validation.1)
            }
          
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
            self.displayPreviouslySelectedServices()
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
            optionMenu.popoverPresentationController?.permittedArrowDirections = .up
            // optionMenu.popoverPresentationController?.sourceRect = attachmentBtn.frame
        }
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    @IBAction func tappedCameraBtn(_ sender: UIButton) {
        self.photosPicker?.media = .photosGalleryAndCamera
        self.photosPicker?.upload = .photo
        //self.photosPicker?.displayActionSheet = false
        self.imageFor = .profile
        self.photosPicker?.showPickerAlert(view: sender)
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
            return viewModel.teacherServices.count
        }
        else{
            return viewModel.teacherQualifications.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == servicesTableView{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "professionCell") as! BankNameTableViewCell
            
            let model = viewModel.teacherServices[indexPath.row]
            cell.labelName.text = (model.name ?? "").capitalized
            
            if indexPath.row == viewModel.teacherServices.count - 1{
                cell.SeperatorLine.isHidden = true
            }
            else{
                cell.SeperatorLine.isHidden = false
            }
            cell.isMultipleSelection = true
            return cell
            
        }
        else if tableView == qualificationsTableview{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreparationCell") as! BankNameTableViewCell
            
            let model = viewModel.teacherQualifications[indexPath.row]
            cell.labelName.text = (model.title ?? "").capitalized
            cell.isMultipleSelection = true
            
            return cell
            
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell") as! BankNameTableViewCell
           // cell.labelName.text = (walkThroughData?.levels?[indexPath.row].name ?? "").capitalized
//            if indexPath.row == (walkThroughData?.levels?.count ?? 0) - 1{
//                cell.SeperatorLine.isHidden = true
//            }else{
//                cell.SeperatorLine.isHidden = false
//            }
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        if tableView == servicesTableView{
        //
        //
        //           // servicesTxtfld.text = ""
        //            servicesTableView.isHidden = true
        //            servicesUnderline.isHidden = true
        //            servicesTabHeight.constant = 0
        //
        //            if isIPad{
        //                servicesBtn.setImage(UIImage(named: "downArrow-iPad"), for: .normal)
        //            }
        //            else{
        //                servicesBtn.setImage(UIImage(named: "downArrow"), for: .normal)
        //            }
        //
        //            servicesView.EnableShadow = false
        //
        //        }
        //
        //        else{
        //            print("Qualification Selected")
        //            selectDeselectRow(tableView: tableView, indexpath:  tableView.indexPathsForSelectedRows)
        //        }
        //
        selectDeselectRow(tableView: tableView, indexpath:  tableView.indexPathsForSelectedRows)
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //   if tableView == qualificationsTableview{
        selectDeselectRow(tableView: tableView, indexpath:  tableView.indexPathsForSelectedRows)
        // }
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
                self.fileType.append("application/msword")
                
            case "pdf":
                documents.append(UIImage(named: "my course-active") ?? UIImage())
                self.fileType.append("application/pdf")
                
            case "jpeg":
                documents.append(UIImage(data: data) ?? UIImage())
                self.fileType.append("image/jpeg")
                
            default:
                documents.append(UIImage(named: "my course-active") ?? UIImage())
                self.fileType.append("image/jpeg")
            }
            
            self.documentsTopBottomConstraint.constant = 16
            documentTopConstraint.constant = 16
            self.documentsCollectionHeight.constant = 100
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.documentsCollectionview.reloadData()
            }
            
            self.fileData.append(data)
            self.fileName.append(generateUniqueName(withSuffix: type))
            self.fileParam.append("document")
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
                self.fileName.append(generateUniqueName(withSuffix: typeString))
                self.fileType.append("image/jpeg")
                
                if isEdit{
                    self.editFileType = "image/jpeg"
                    self.editFileName = generateUniqueName(withSuffix: typeString)
                }
                
            case .audio:
//                typeString = ".m4a"
//                self.fileName.append(generateUniqueName(withSuffix: typeString))
//                self.fileType.append("audio/m4a")
//
//                if isEdit{
//                    self.editFileType = "audio/m4a"
//                }
                break
                
            case .video:
//                typeString = ".mp4"
//                self.fileName.append(generateUniqueName(withSuffix: typeString))
//                self.fileType.append("video/mp4")
//
//                if isEdit{
//                    self.editFileType = "video/mp4"
//                }
                break
                
            default:
                break
            }
            
            if imageFor == .documents{
                documents.append(UIImage(data: data) ?? UIImage())
                self.documentsTopBottomConstraint.constant = 16
                documentTopConstraint.constant = 16
                self.documentsCollectionHeight.constant = 100
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.documentsCollectionview.reloadData()
                }
                
                self.fileParam.append("document")
            }
            else{
                self.userProfileImage.image = UIImage(data: data) ?? UIImage()
                self.fileParam.append("profile")
                
                if isEdit{
                    self.editFileParam = "profile"
                }
            }
            
            self.fileData.append(data)
            
            if isEdit{
                self.editFileData = data
            }
        }
    }
}

//MARK: - API Calls

extension SignupViewController{
    
    func signupApi(){
        
        Indicator.shared.showProgressView(self.view)
        
        viewModel.signup(name: fullnameTxtFld.text ?? "", email: emailTxtFld.text ?? "", password: passwordTxtFld.text ?? "", mobile: mobileTextField.text!, experience: experienceTxtFld.text!, services: self.viewModel.teacherServices.filter({$0.isSelected ?? false}).map({"\($0.id ?? 0)"}), qualifications: self.viewModel.teacherQualifications.filter({$0.isSelected ?? false}).map({"\($0.id ?? 0)"}), introduction: introductionTxtFld.text!, about: AboutTxtView.text, fileName: self.fileName, fileType: fileType, fileData: fileData, fileParam: fileParam) { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
              
                self.showAlertWithAction(Title: "", Message: "Signup Successful.Please wait for admin approval.", ButtonTitle: "OK") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
    func editProfileApi(){
        
        Indicator.shared.showProgressView(self.view)
        
        viewModel.editProfile(name: fullnameTxtFld.text ?? "", email: emailTxtFld.text ?? "", mobile: mobileTextField.text!, experience: experienceTxtFld.text!, introduction: introductionTxtFld.text!, about: AboutTxtView.text, fileName: self.editFileName, fileType: editFileType, fileData: editFileData, fileParam: editFileParam) { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
              
                self.showAlertWithAction(Title: "", Message: "Profile Edited Successfully!", ButtonTitle: "OK") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
    func servicesListing(){
        
        viewModel.getServices { isSuccess, message in
            
            if isSuccess{
                self.servicesTableView.reloadData()
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
    func qualificationsListing(){
        
        viewModel.getQualifications { isSuccess, message in
            
            if isSuccess{
                self.qualificationsTableview.reloadData()
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
//            print("user has moved back from signup. Removing cached data to remove any inappropriate behaviour")
//            UserDefault.sharedInstance?.removeUserData()
//            UserDefault.sharedInstance?.updateUserData()
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

//MARK: - UItextField Delegates

extension SignupViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == introductionTxtFld{
            return range.location < 100
        }
        else{
            return true
        }
        
    }
    
}
