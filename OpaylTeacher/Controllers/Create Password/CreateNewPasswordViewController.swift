//
//  CreateNewPasswordViewController.swift
//  IletsLearning
//
//  Created by OPAYN on 25/10/21.
//

import UIKit

class CreateNewPasswordViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var newPasswordTxtFld: RoundTextField!
    @IBOutlet weak var confirmPasswordTxtFld: RoundTextField!
    
    //MARK: - Variables
    
    var code = ""
    var viewModel = SignupViewModel()
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        navigationWithBack(navtTitle: "", titleType: .large, titleColor: .black)
    }
    
    //MARK: - Custom Methods
    
    //MARK: - Objc Methods
    
    //MARK: - IBActions
    
    @IBAction func tappedSubmitBtn(_ sender: UIButton) {
        
        let validation = viewModel.createNewPassValidation(newPass: newPasswordTxtFld.text ?? "", confirmPass: confirmPasswordTxtFld.text ?? "")
      
        if validation.0{
            resetPassword()
        }
        else{
            self.showToast(message: validation.1)
        }
       
    }
    
}

//MARK: - API Calls

extension CreateNewPasswordViewController{
    
    func resetPassword(){
        
        Indicator.shared.showProgressView(self.view)
        
        viewModel.resetPassword(password: self.newPasswordTxtFld.text ?? "",confirm_password:confirmPasswordTxtFld.text ?? "",code: self.code) { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.hideBack = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}

