//
//  CustomUrlViewController.swift
//  OpaylTeacher
//
//  Created by OPAYN on 29/01/22.
//

import UIKit

class CustomUrlViewController: UIViewController {

    @IBOutlet weak var mainContainerView: SetView!
    @IBOutlet weak var meetingUrlTxtField: SetTextField!
    
    var cb = ((String)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        super.touchesBegan(touches, with: event)

        let touch = touches.first
        
        guard let location = touch?.location(in: self.view) else { return }
       
        if !mainContainerView.frame.contains(location) {
            print("Tapped outside the view")
            self.dismiss(animated: true, completion: nil)
        } else {
            print("Tapped inside the view")
        }
    }
    
    
    @IBAction func tappedGenerateBtn(_ sender: UIButton) {
        
        if meetingUrlTxtField.text?.isEmpty ?? false{
            
        }
        else{
            
        }
    }
    
}
