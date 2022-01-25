//
//  CustomTabBar.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 03/11/21.
//

import Foundation
import UIKit

@IBDesignable class TabBarWithCorners: UITabBar {
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 30.0

    private var shapeLayer: CALayer?

    override func draw(_ rect: CGRect) {
        if UIDevice().userInterfaceIdiom == .pad{
            radii += 10
        }
        
        addShape()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if UIDevice().userInterfaceIdiom == .pad{
           // var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 80
            return sizeThatFits
        }
        else{
            
            sizeThatFits.height += 4
            //sizeThatFits.height = 70
            return sizeThatFits
        }

       }

    private func addShape() {
        let shapeLayer = CAShapeLayer()
    
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.shadowColor = UIColor.lightGray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shapeLayer.shadowRadius = 4.0
        shapeLayer.shadowOpacity = 1.0
    
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
    
        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radii, height: 0.0))
    
        return path.cgPath
    }
}
