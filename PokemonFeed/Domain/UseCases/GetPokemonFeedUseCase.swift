//
//  GetPokemonFeedUseCase.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Combine

/// Get pokemon array UseCase interface
protocol GetPokemonFeedUseCase {
  /// Performs request asynchronously with propagating result pokemon array through AnyPublisher
  func invoke(query: PokemonFeedQuery?) -> AnyPublisher<[Pokemon], Error>
}
