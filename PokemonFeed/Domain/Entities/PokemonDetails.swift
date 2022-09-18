//
//  PokemonDetails.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Foundation

protocol PokemonDetails {
  var sprite: String? { get }
  var height: Int { get }
  var weight: Int { get }
  var abilities: [String] { get }
}
