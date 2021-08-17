//
//  RunewordCell.swift
//  D2RuneWords
//
//  Created by Adam Ake on 8/16/21.
//

import UIKit

class RunewordCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var runeLabel: UILabel!
  @IBOutlet weak var benefitsLabel: UILabel!
  @IBOutlet weak var equipmentLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layer.borderWidth = 1
    layer.borderColor = orangeColor.withAlphaComponent(1).cgColor
    layer.cornerRadius = 5
  }
  
  func setup(runeword: Runewords) {
    let title = NSMutableAttributedString(string: "\(runeword.runeword.title.lowercased())", attributes: [.font: diabloFont(size: 28), .foregroundColor: orangeColor])
    titleLabel.attributedText = title
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    let attributedString = NSMutableAttributedString(string: runeword.runeword.benefitsDescription,
                                                     attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                                  .paragraphStyle : paragraphStyle])
    benefitsLabel.attributedText = attributedString
    runeLabel.text = runeword.runeword.runewordDescription
    equipmentLabel.text = runeword.runeword.equipmentDescription
  }
}
