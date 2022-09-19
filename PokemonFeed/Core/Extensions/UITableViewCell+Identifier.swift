//
//  UITableViewCell+Identifier.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

extension UITableViewCell {
  /// Returns identifier for cell type
  static var identifier: String {
    String(describing: self)
  }
}
