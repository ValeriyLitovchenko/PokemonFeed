//
//  PokemonSpecies.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Foundation

protocol PokemonSpecies {
  var generation: String { get }
  var growthRate: String { get }
  var habitat: String { get }
  var varieties: [PokemonVariety] { get }
}
