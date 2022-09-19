//
//  PokemonFeedStorage.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Combine

/// Interface for pokemons storage
protocol PokemonFeedStorage {
  // Performs pokemons fetching asynchronously with propagating result through AnyPublisher
  func getPokemonFeed(for request: PokemonFeedRequestDTO?) -> AnyPublisher<[Pokemon], Error>
  // Saves pokemons
  func save(pokemonFeed: [Pokemon])
}
