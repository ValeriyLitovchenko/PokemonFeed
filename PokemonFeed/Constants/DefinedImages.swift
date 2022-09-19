//
//  DefinedImages.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import UIKit

enum DefinedImages {
  static let pokeball = ImageResource(name: "pokeball")
}

struct ImageResource {
  let name: String
  
  var image: UIImage? {
    let image = UIImage(named: name)
    assert(image != nil, "Image with name \(name) does not exist")
    return image
  }
}
