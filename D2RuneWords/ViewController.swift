//
//  ViewController.swift
//  D2RuneWords
//
//  Created by Adam Ake on 8/15/21.
//

import UIKit

let orangeColor = UIColor(red: 210/255.0, green: 162/255.0, blue: 35/255.0, alpha: 1)

func diabloFont(size: CGFloat) -> UIFont {
  return UIFont(name: "Diabolica", size: size)!
}

enum Cells {
  case rune(Rune)
  case runeword(Runewords)
}

class ViewController: UIViewController {
  
  private var viewsWereLaidOut = false
  @IBOutlet weak var navBar: UIView!
  @IBOutlet weak var matchesButton: UIButton!
  private var selections: [Rune] = []
  private var lastMatchCount = 0
  @IBOutlet weak var clearControl: UIVisualEffectView!
  @IBOutlet weak var xButton: UIButton!
  
  let allRunes = Rune.allCases
  var items = [Cells]()
  private var matches = [Cells]()

  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  func insertRunes() {
    items.removeAll()
    for rune in Rune.allCases {
      items.append(.rune(rune))
    }
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if viewsWereLaidOut == false {
      viewsWereLaidOut = true
      
      insertRunes()
      collectionView.contentInset = UIEdgeInsets(top: navBar.frame.height - view.safeAreaInsets.top + 10, left: 15, bottom: 0, right: 15)
      collectionView.register(UINib(nibName: "ClearCell", bundle: nil), forCellWithReuseIdentifier: "ClearCell")
      collectionView.register(UINib(nibName: "RuneSquareCell", bundle: nil), forCellWithReuseIdentifier: "RuneSquareCell")
      collectionView.register(UINib(nibName: "RunewordCell", bundle: nil), forCellWithReuseIdentifier: "RunewordCell")
      
      matchesButton.layer.cornerRadius = 4
      matchesButton.layer.borderWidth = 1
      matchesButton.layer.borderColor = orangeColor.cgColor
      
      DispatchQueue.main.async {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.navBar.layer.shadowColor = UIColor.black.cgColor
        self.navBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.navBar.layer.shadowRadius = 20
        self.navBar.layer.shadowOpacity = 1
        
        self.findMatches()
      }
    }
  }
  
  private func findMatches() {
    var matches = [Runewords]()
    self.matches = []
    
    insertRunes()
    
    for runeword in Runewords.allCases {
      let runesInRuneword = Set(runeword.runeword.runes)
      let runesUserSelected = Set(selections)
      if runesInRuneword.isSubset(of: runesUserSelected) {
        matches.append(runeword)
      }
    }
    
    // Updating the button with the number of found matches
    if matches.count == 0 {
      let selectAll = NSAttributedString(string: "Select All".lowercased(), attributes: [.font: diabloFont(size: 22), .foregroundColor: orangeColor])
      matchesButton.setAttributedTitle(selectAll, for: .normal)
      matchesButton.fade()
    } else {
      let attributedNumber = NSMutableAttributedString(string: "\(matches.count)", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor: orangeColor])
      let matchesText = NSAttributedString(string: " match\(matches.count > 1 || matches.count == 0 ? "es" : "")", attributes: [.font: diabloFont(size: 24), .foregroundColor: orangeColor])
      attributedNumber.append(matchesText)
      matchesButton.setAttributedTitle(attributedNumber, for: .normal)
      matchesButton.fade()
    }
    
    // Add the matches to the collection info, and reload the view.
    for match in matches {
      self.matches.append(.runeword(match))
    }
    
    if matches.count != lastMatchCount {
      lastMatchCount = matches.count
      if collectionView.numberOfSections > 1 {
        collectionView.reloadSections(IndexSet(integer: 1))
      } else {
        collectionView.reloadData()
      }
    }
    
    setClearControl(isVisible: !self.selections.isEmpty)
  }
  
  @IBAction func tappedMatches(_ sender: Any) {
    if !matches.isEmpty {
      collectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .top, animated: true)
    } else {
      selectAll()
      collectionView.reloadSections(IndexSet(integer: 0))
      findMatches()
      
      DispatchQueue.main.async {
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .top, animated: true)
      }
    }
  }
  
  private func selectAll() {
    selections = allRunes
  }
  
  @IBAction func tappedClear(_ sender: Any) {
    clearSelection()
  }
  
  func setClearControl(isVisible: Bool) {
    if isVisible && self.clearControl.alpha < 0.99 {
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {
        self.clearControl.alpha = 1
        self.clearControl.transform = .identity
        self.xButton.transform = .identity
      }, completion: nil)
    } else if !isVisible && self.clearControl.alpha > 0.01 {
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {
        self.clearControl.alpha = 0
        self.clearControl.transform = .init(translationX: 120, y: 0).concatenating(.init(scaleX: 0.2, y: 0.2))
        self.xButton.transform = .init(rotationAngle: 3)
      }, completion: nil)
    }
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 {
      return items.count
    } else {
      return matches.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.section == 0 {
      // Rendering rune cells
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RuneSquareCell", for: indexPath) as? RuneSquareCell
      var rune = Rune.El
      switch items[indexPath.item] {
      case .rune(let unwrappedRune):
        rune = unwrappedRune
      default:
        break
      }
      cell?.setup(rune: rune)
      cell?.set(isSelected: selections.contains(rune))
      return cell!
    } else {
      // Rendering matching runewords
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RunewordCell", for: indexPath) as? RunewordCell
      switch matches[indexPath.item] {
      case .runeword(let runeword):
        cell?.setup(runeword: runeword)
      default:
        break
      }
      return cell!
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      let columnCount: CGFloat = 5
      let width = ((collectionView.frame.width - 30) - ((columnCount - 1) * 5)) / columnCount
      let height = width + 30
      return CGSize(width: width, height: height)
    } else {
      let width = (collectionView.frame.width - 30)
      let baseheight: CGFloat = 94
      
      var runeword = Runewords.AncientsPledge
      switch matches[indexPath.item] {
      case .runeword(let unwrappedRuneword):
        runeword = unwrappedRuneword
      default:
        break
      }
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = 4
      let attributedString = NSMutableAttributedString(string: runeword.runeword.benefitsDescription,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                                    .paragraphStyle : paragraphStyle])
      let height = attributedString.height(containerWidth: width - 40) + baseheight
      return CGSize(width: width, height: height + 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if section == 0 {
      return .zero
    } else {
      return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    if indexPath.section == 1 {
      return
    }
    
    // Else, user has selected a rune
    if selections.contains(allRunes[indexPath.item]) {
      selections.remove(at: selections.firstIndex(of: allRunes[indexPath.item])!)
    } else {
      selections.append(allRunes[indexPath.item])
    }
    
    if let cell = collectionView.cellForItem(at: indexPath) as? RuneSquareCell {
      cell.set(isSelected: selections.contains(allRunes[indexPath.item]))
    }
    
    findMatches()
  }
  
  func clearSelection() {
    for cell in collectionView.visibleCells {
      if let cell = cell as? RuneSquareCell, let indexPath = collectionView.indexPath(for: cell) {
        if selections.contains(where: {($0.index - 1) == indexPath.item}) {
          cell.set(isSelected: false)
        }
      }
    }
    
    selections.removeAll()
    findMatches()
    return
  }
}
