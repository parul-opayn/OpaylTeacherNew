//
//  HeartButton.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 29/11/21.
//

import Foundation
import UIKit

class HeartButton: UIButton {
  private var isLiked = false
  
  private let unlikedImage = UIImage(named: "UnfavouriteIcon")
  private let likedImage = UIImage(named: "favouriteBtn")
  
    private let unlikedScale: CGFloat = 0.95
  private let likedScale: CGFloat = 1.4

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setImage(unlikedImage, for: .normal)
      }
      
      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }
    
    public func flipLikedState(isLiked: Bool) {
        self.isLiked = isLiked
    animate()
  }

  private func animate() {
    UIView.animate(withDuration: 0.2, animations: {
      let newImage = self.isLiked ? self.likedImage : self.unlikedImage
      let newScale = self.isLiked ? self.likedScale : self.unlikedScale
      self.transform = self.transform.scaledBy(x: newScale, y: newScale)
      self.setImage(newImage, for: .normal)
    }, completion: { _ in
      UIView.animate(withDuration: 0.2, animations: {
        self.transform = CGAffineTransform.identity
      })
    })
  }
}
