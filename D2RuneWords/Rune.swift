//
//  File.swift
//  D2RuneWords
//
//  Created by Adam Ake on 8/15/21.
//

import UIKit

enum Rune: String, CaseIterable {
  case El
  case Eld
  case Tir
  case Nef
  case Eth
  case Ith
  case Tal
  case Ral
  case Ort
  case Thul
  case Amn
  case Sol
  case Shael
  case Dol
  case Hel
  case Io
  case Lum
  case Ko
  case Fal
  case Lem
  case Pul
  case Um
  case Mal
  case Ist
  case Gul
  case Vex
  case Ohm
  case Lo
  case Sur
  case Ber
  case Jah
  case Cham
  case Zod
  
  var image: UIImage {
    switch self {
    
    case .El:
      return #imageLiteral(resourceName: "ElRune")
    case .Eld:
      return #imageLiteral(resourceName: "EldRune")
    case .Tir:
      return #imageLiteral(resourceName: "tirRune")
    case .Nef:
      return #imageLiteral(resourceName: "nefRune")
    case .Eth:
      return #imageLiteral(resourceName: "EthRune")
    case .Ith:
      return #imageLiteral(resourceName: "ithRune")
    case .Tal:
      return #imageLiteral(resourceName: "talRune")
    case .Ral:
      return #imageLiteral(resourceName: "ralRune")
    case .Ort:
      return #imageLiteral(resourceName: "ortRune")
    case .Thul:
      return #imageLiteral(resourceName: "thulRune")
    case .Amn:
      return #imageLiteral(resourceName: "AmnRune")
    case .Sol:
      return #imageLiteral(resourceName: "solRune")
    case .Shael:
      return #imageLiteral(resourceName: "shaelRune")
    case .Dol:
      return #imageLiteral(resourceName: "DolRune")
    case .Hel:
      return #imageLiteral(resourceName: "helRune")
    case .Io:
      return #imageLiteral(resourceName: "ioRune")
    case .Lum:
      return #imageLiteral(resourceName: "lumRune")
    case .Ko:
      return #imageLiteral(resourceName: "koRune")
    case .Fal:
      return #imageLiteral(resourceName: "falRune")
    case .Lem:
      return #imageLiteral(resourceName: "lemRune")
    case .Pul:
      return #imageLiteral(resourceName: "pulRune")
    case .Um:
      return #imageLiteral(resourceName: "umRune")
    case .Mal:
      return #imageLiteral(resourceName: "malRune")
    case .Ist:
      return #imageLiteral(resourceName: "istRune")
    case .Gul:
      return #imageLiteral(resourceName: "gulRune")
    case .Vex:
      return #imageLiteral(resourceName: "vexRune")
    case .Ohm:
      return #imageLiteral(resourceName: "ohmRune")
    case .Lo:
      return #imageLiteral(resourceName: "loRune")
    case .Sur:
      return #imageLiteral(resourceName: "surRune")
    case .Ber:
      return #imageLiteral(resourceName: "BerRune")
    case .Jah:
      return #imageLiteral(resourceName: "jahRune")
    case .Cham:
      return #imageLiteral(resourceName: "ChamRune")
    case .Zod:
      return #imageLiteral(resourceName: "zodRune")
    }
  }
  
  var index: Int {
    return (Rune.allCases.firstIndex(of: self) ?? 0) + 1
  }
}
