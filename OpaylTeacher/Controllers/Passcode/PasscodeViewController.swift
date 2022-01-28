//
//  PasscodeViewController.swift
//  IletsLearning
//
//  Created by OPAYN on 25/10/21.
//

import UIKit

class PasscodeViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var codeTxtFld: RoundTextField!
    @IBOutlet weak var instructionLbl: AtMentionsLabel!
    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var resendBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var resendTop: NSLayoutConstraint!
    
    //MARK: - Variables
    
    var displayFor:otpVerificationFor = .forgotPassword
    var viewModel = SignupViewModel()
    var id = ""
    var resendCount = 0
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.instructionLbl.tapDelegate = self
            self.instructionLbl.mentions = ["4-digit code"]
        }
        codeTxtFld.delegate = self
        
        if UserDefault.sharedInstance?.getUserDetails()?.id == nil{
            resendCodeBtn.isHidden = true
            resendBtnHeight.constant = 0
            resendTop.constant = 0
        }
        else{
            resendCodeBtn.isHidden = false
            resendBtnHeight.constant = 32
            resendTop.constant = 8
        }
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        navigationWithBack(navtTitle: "", titleType: .large, titleColor: .black)
    }
    
    //MARK: - Custom Methods
    
    //MARK: - Objc Methods
    
    //MARK: - IBActions
    
    @IBAction func tappedDoneBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        if self.codeTxtFld.text?.replacingOccurrences(of: " ", with: "") == ""{
            self.showToast(message: "Please enter code.")
        }
        else{
            
            if displayFor == .login || displayFor == .signup{
                verifyOTP()
            }
            
            else if displayFor == .forgotPassword{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewPasswordViewController") as! CreateNewPasswordViewController
                vc.code = codeTxtFld.text ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
           
        }
        
    }
    
    @IBAction func tappedResendCodeBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        if resendCount < 3{
            self.resendOTP()
        }
        else{
            self.showToast(message: "You have exceed resend code limit.")
        }
    }
    
    
    
}

//MARK: - HyperLink Label Protocol

extension PasscodeViewController:AtMentionsLabelTapDelegate{
    
    func labelWasTappedForUsername(_ username: String) {
        print("tapped string = \(username)")
    }

}


//MARK: - API Calls

extension PasscodeViewController{
    
    func verifyOTP(){
        
        Indicator.shared.showProgressView(self.view)
        
        viewModel.otpVerification(id: self.id,code: codeTxtFld.text ?? "") { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
                
                if self.displayFor == .login{
                    self.showToast(message: "OTP Verified successfully. You can login to continue")
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    vc.hideBack = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
               
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
    
    func resendOTP(){
        
        Indicator.shared.showProgressView(self.view)
        
        viewModel.resendCode(id: self.id) { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
                self.showToast(message: "Code sent successfully.")
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}

//MARK: - UItextField Delegates

extension PasscodeViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location <= 4
    }
    
}
