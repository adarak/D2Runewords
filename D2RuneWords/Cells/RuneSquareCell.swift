//
//  RuneSquareCell.swift
//  D2RuneWords
//
//  Created by Adam Ake on 8/15/21.
//

import UIKit



class RuneSquareCell: UICollectionViewCell {
  
  @IBOutlet weak var runeImageView: UIImageView!
  @IBOutlet weak var runeLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var burstBackgroundImageView: UIImageView!
  
  var rune: Rune!
  
  func setup(rune: Rune) {
    self.rune = rune
    backgroundColor = .clear
    layer.cornerRadius = 10
    self.runeLabel.text = rune.rawValue
    self.runeImageView.image = rune.image
    self.numberLabel.text = "\((rune.index < 10) ? "0" : "")\(rune.index)"
    
    styleBasedOnRank()
  }
  
  func set(isSelected: Bool) {
    if isSelected {
      layer.borderWidth = 1
      layer.borderColor = orangeColor.cgColor
    } else {
      layer.borderWidth = 0
    }
    self.fade()
  }
  
  func styleBasedOnRank() {
    switch rune.index {
    case 1...11:
      burstBackgroundImageView.tintColor = .clear
    case 12...21:
      burstBackgroundImageView.tintColor = .white.withAlphaComponent(0.5)
    case 22...33:
      burstBackgroundImageView.tintColor = .white
    default:
      break
    }
  }
}
