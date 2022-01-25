//
//  ForgotPasswordViewController.swift
//  IletsLearning
//
//  Created by OPAYN on 25/10/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTxtFld: RoundTextField!
    @IBOutlet weak var instructionLbl: AtMentionsLabel!
    
    //MARK: - Variables
    
    var viewModel = ForgotPasswordViewModel()
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.instructionLbl.tapDelegate = self
            self.instructionLbl.mentions = ["4-digit code"]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        navigationWithBack(navtTitle: "", titleType: .large, titleColor: .black)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    //MARK: - Custom Methods
    
    //MARK: - Objc Methods
    
    //MARK: - IBActions
    
    @IBAction func tappedSubmitBtn(_ sender: UIButton) {
        self.view.endEditing(true)
        if emailTxtFld.text?.replacingOccurrences(of: " ", with: "") == ""{
            self.showToast(message: "Please enter email")
        }
        else if !Validation().validateEmailId(emailID: emailTxtFld.text ?? ""){
            self.showToast(message: "Please enter valid email")
        }
        else{
            forgotPasswordAPI()
        }
    }
    
}

//MARK: - HyperLink Label Protocol

extension ForgotPasswordViewController:AtMentionsLabelTapDelegate{
    
    func labelWasTappedForUsername(_ username: String) {
        print("tapped string = \(username)")
    }

}

//MARK: - API Calls

extension ForgotPasswordViewController{
    
    func forgotPasswordAPI(){
        
        Indicator.shared.showProgressView(self.view)
        
        viewModel.forgotPassword(email: emailTxtFld.text ?? "") { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PasscodeViewController") as! PasscodeViewController
                vc.displayFor = .forgotPassword
                vc.id = "\(UserDefault.sharedInstance?.getUserDetails()?.id ?? 0)"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}

