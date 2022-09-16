//
//  Pokemon.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Foundation

protocol Pokemon {
  var id: String { get }
  var name: String { get }
  var sprite: String { get }
}
