//
//  Extensions.swift
//  D2RuneWords
//
//  Created by Adam Ake on 8/16/21.
//

import UIKit

extension UIView {
  
  func slideIn(direction: CATransitionSubtype) {
    if Thread.current.isMainThread {
      performSlide(direction: direction)
    } else {
      DispatchQueue.main.async {
        self.performSlide(direction: direction)
      }
    }
  }
  
  
  func fade() {
    if Thread.current.isMainThread {
      performFade()
    } else {
      DispatchQueue.main.async {
        self.performFade()
      }
    }
  }
  
  private func performFade() {
    let transition = CATransition()
    transition.duration = 0.1
    transition.type = .fade
    transition.subtype = .fromBottom
    transition.isRemovedOnCompletion = true
    self.layer.add(transition, forKey: "transitionAnimation")
  }
  
  private func performSlide(direction: CATransitionSubtype) {
    let transition = CATransition()
    transition.duration = 0.25
    transition.type = .push
    transition.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0.1, 0.2, 1)
    transition.subtype = direction
    transition.isRemovedOnCompletion = true
    self.layer.add(transition, forKey: "transitionAnimation")
  }
}

extension NSAttributedString {
  
  func height(containerWidth: CGFloat) -> CGFloat {
    let rect = self.boundingRect(with: CGSize.init(width: containerWidth, height: CGFloat.greatestFiniteMagnitude),
                                 options: [.usesLineFragmentOrigin, .usesFontLeading],
                                 context: nil)
    return ceil(rect.size.height)
  }
}
