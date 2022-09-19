//
//  PokemonFeedRepository.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Combine

/// Interface for pokemons repository
protocol PokemonFeedRepository {
  // Performs pokemons fetching asynchronously with propagating result through AnyPublisher
  func getPokemonFeed(query: PokemonFeedQuery?) -> AnyPublisher<[Pokemon], Error>
}
