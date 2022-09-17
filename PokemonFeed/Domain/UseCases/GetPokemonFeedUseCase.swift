//
//  GetPokemonFeedUseCase.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Combine

protocol GetPokemonFeedUseCase {
  func invoke(query: PokemonFeedQuery?) -> AnyPublisher<[Pokemon], Error>
}
