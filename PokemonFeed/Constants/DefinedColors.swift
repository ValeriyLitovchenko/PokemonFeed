//
//  DefinedColors.swift
//  PokemonFeed
//
//  Created by Valeriy L on 19.09.2022.
//

import UIKit

enum DefinedColors {
  static let lightCellSelectionColor = ColorResource(name: "lightCellSelectionColor")
}

struct ColorResource {
  let name: String
  
  var color: UIColor? {
    let color = UIColor(named: name)
    assert(color != nil, "Asset Color with name \(name) does not exist")
    return color
  }
}
