//
//  PokemonFeedPage.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

protocol PokemonFeedPage {
  var totalCount: Int { get }
  var pokemons: [Pokemon] { get }
}
