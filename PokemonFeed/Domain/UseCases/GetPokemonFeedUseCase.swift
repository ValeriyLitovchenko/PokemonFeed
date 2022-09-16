//
//  GetPokemonFeedUseCase.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Combine

protocol GetPokemonFeedUseCase {
  func invoke() -> AnyPublisher<[Pokemon], Error>
}
