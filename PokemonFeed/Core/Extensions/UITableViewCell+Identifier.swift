//
//  UITableViewCell+Identifier.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

extension UITableViewCell {
  static var identifier: String {
    String(describing: self)
  }
}
