//
//  PokemonFeedRepository.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Combine

protocol PokemonFeedRepository {
  func getPokemonFeed(query: PokemonFeedQuery?) -> AnyPublisher<[Pokemon], Error>
}
