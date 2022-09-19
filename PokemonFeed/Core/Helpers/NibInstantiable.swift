//
//  NibInstantiable.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

/// Interface for instantiating nib file for UI elements
protocol NibInstantiable: NSObjectProtocol {
  static var nib: UINib { get }
}

extension NibInstantiable {
  static var nib: UINib {
    let nibName = String(describing: self)
    
    guard Bundle.main.path(
      forResource: nibName,
      ofType: "nib") != nil else {
        
        fatalError("Interface instructions (xib file) does not exist for \(nibName)")
      }
    
    return UINib(nibName: nibName, bundle: nil)
  }
}
