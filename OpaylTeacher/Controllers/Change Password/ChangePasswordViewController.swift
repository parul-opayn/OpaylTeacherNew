//
//  ChangePasswordViewController.swift
//  IletsLearning
//
//  Created by OPAYN on 27/10/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var oldPasswordTxtFld: RoundTextField!
    @IBOutlet weak var newPasswordTxtFld: RoundTextField!
    @IBOutlet weak var confirmPasswordTxtFld: RoundTextField!
    
    var viewModel = ChagePasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationWithBack(navtTitle: "Change Password", titleType: .large, titleColor: .black)
    }

    @IBAction func tappedSubmitBtn(_ sender: UIButton) {
        
        let validation = viewModel.validation(oldPass: oldPasswordTxtFld.text ?? "", newPas: newPasswordTxtFld.text ?? "", confirmPass: confirmPasswordTxtFld.text ?? "")
       
        if validation.0{
            changePassword()
        }
        else{
            self.showToast(message: validation.1)
        }
        
    }
}

//MARK: - API Calls

extension ChangePasswordViewController{
    
    func changePassword(){
        
        Indicator.shared.showProgressView(self.view)
        viewModel.changePassword(oldPassword: oldPasswordTxtFld.text ?? "", newPassword: newPasswordTxtFld.text ?? "") { isSuccess, message in
            
            Indicator.shared.hideProgressView()
            
            if isSuccess{
                self.showToast(message: "Password changed successfully")
                let vc = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                vc.hideBack = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}
