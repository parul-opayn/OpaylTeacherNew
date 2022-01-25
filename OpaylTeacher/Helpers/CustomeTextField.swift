//
//  CustomeTextField.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 22/10/21.
//

import Foundation
import UIKit

class CustomTextField: UITextField{

   let dashBorder = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        dashBorder.strokeColor = UIColor.lightGray.cgColor
        dashBorder.fillColor = nil
        dashBorder.lineDashPattern = [4, 2]
        layer.addSublayer(dashBorder)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
        dashBorder.frame = bounds
    }

}
