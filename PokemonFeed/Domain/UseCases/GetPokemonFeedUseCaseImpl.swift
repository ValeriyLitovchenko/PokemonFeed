//
//  GetPokemonFeedUseCaseImpl.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Combine

struct GetPokemonFeedUseCaseImpl: GetPokemonFeedUseCase {
  let pokemonFeedRepository: PokemonFeedRepository
  
  func invoke() -> AnyPublisher<[Pokemon], Error> {
    pokemonFeedRepository.getPokemonFeed()
  }
}
