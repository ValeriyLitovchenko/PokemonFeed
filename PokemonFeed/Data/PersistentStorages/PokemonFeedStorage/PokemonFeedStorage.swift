//
//  PokemonFeedStorage.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Combine

protocol PokemonFeedStorage {
  func getPokemonFeed(for request: PokemonFeedRequestDTO?) -> AnyPublisher<[Pokemon], Error>
  func save(pokemonFeed: [Pokemon])
}
