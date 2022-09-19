//
//  GetPokemonDetailsUseCase.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Combine

/// Get pokemon detailed data UseCase interface
protocol GetPokemonDetailsUseCase {
  /// Performs request asynchronously with propagating result pokemon details data through AnyPublisher
  func invoke(_ pokemonId: String) -> AnyPublisher<PokemonDetails, Error>
}
