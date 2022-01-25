//
//  LoginViewController.swift
//  IletsLearning
//
//  Created by OPAYN on 25/10/21.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class LoginViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTxtFld: RoundTextField!
    @IBOutlet weak var passwordTxtFld: RoundTextField!
    @IBOutlet weak var logoTop: NSLayoutConstraint!
    
    //MARK: - Variables
    
    var viewModel = LoginViewModel()
    var hideBack = false
    var moveBack = false
    var socialId = ""
    var socialEmail = ""
    var socialName = ""
    let signInConfig = GIDConfiguration.init(clientID: "583565093307-opsg2hp834ojq77012ji8a591e69era5.apps.googleusercontent.com")
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if targetEnvironment(simulator)
        emailTxtFld.text = "parul@mailinator.com"
        passwordTxtFld.text = "123456"
        
#endif
        
        if hideBack{
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            self.logoTop.constant = 40
        }
        else{
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            navigationWithBack(navtTitle: "", titleType: .large, titleColor: .black)
            self.logoTop.constant = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        if hideBack{
            self.navigationController?.isNavigationBarHidden = true
            self.logoTop.constant = 46
        }
        else{
            self.navigationController?.isNavigationBarHidden = false
            navigationWithBack(navtTitle: "", titleType: .large, titleColor: .black)
            self.logoTop.constant = 0
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Custom Methods
    
    //MARK: - Objc Methods
    
    //MARK: - IBActions
    
    @IBAction func tappedForgotPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tappedSignupBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.navigationController?.pushViewController(vc,animated: true)
        //        let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "BasicInfoViewController") as! BasicInfoViewController
        //        self.navigationController?.pushViewController(vc,animated: true)
    }
    
    @IBAction func tappedLoginBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        let validation = viewModel.validations(email: emailTxtFld.text ?? "", password: passwordTxtFld.text ?? "")
        
//        if validation.0{
//            self.loginApi()
//        }
//        else{
//            self.showToast(message: validation.1)
//        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainDashboardViewController") as! MainDashboardViewController
        self.navigationController?.pushViewController(vc,animated: true)
        
    }
    
    @IBAction func tapGoogleSignin(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { [self] user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            self.socialEmail = user.profile?.email ?? ""
            self.socialName = user.profile?.name ?? ""
            self.socialId = "\(user.userID ?? "")"
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            print("Name: \(socialName), GiveName: \(givenName ?? ""), familyName: \(familyName ?? ""), email: \(socialEmail), profileImage: \(String(describing: profilePicUrl))")
            self.socialLoginApi()
        }
    }
    
    @IBAction func tapAppleSignIn(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        }
        else {
            showAlert(Title: "iOS Unsupported", Message: "Apple Sign in is supported only in iOS 13+.", ButtonTitle: "Ok")
        }
    }
    
    @IBAction func continueAsGuestBtnTapped(_ sender: UIButton) {
        
//        let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
//        UserDefault.sharedInstance?.removeUserData()
//        UserDefault.sharedInstance?.updateUserData()
//        vc.selectedIndex = 0
//        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: - API Calls

extension LoginViewController{
    
    func loginApi(){
        
        Indicator.shared.showProgressView(self.view)
        
        viewModel.login(email: emailTxtFld.text ?? "", password: passwordTxtFld.text ?? "") { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
                
//                if (UserDefault.sharedInstance?.getUserDetails()?.emailVerifiedAt ?? "") == ""{
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasscodeViewController") as! PasscodeViewController
//                    vc.displayFor = .login
//                    vc.id = "\(UserDefault.sharedInstance?.getUserDetails()?.id ?? 0)"
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//                else{
//                    if self.moveBack{
//                        self.navigationController?.popViewController(animated: true)
//                    }
//                    else{
//                        let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
//                        vc.selectedIndex = 4
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                }
                
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
    
    func socialLoginApi(){
        
        Indicator.shared.showProgressView(self.view)
        
        viewModel.socialLogin(email: socialEmail, name: socialName, id: socialId) { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
                
//                if self.moveBack{
//                    self.navigationController?.popViewController(animated: true)
//                }
//                else{
//                    let vc = storyBoardIdentifiers.courses.getStoryBoard().instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
//                    vc.selectedIndex = 4
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
                
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}

//MARK: - Authorization delegate

extension LoginViewController: ASAuthorizationControllerDelegate{
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            socialId = appleIDCredential.user
            socialName = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
            socialEmail = appleIDCredential.email ?? ""
            print("User id is \(socialId) \n Full Name is \(String(describing: socialName)) \n Email id is \(String(describing: socialEmail))")
            self.socialLoginApi()
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
}
