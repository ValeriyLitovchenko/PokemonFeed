//
//  GetPokemonSpeciesUseCase.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Combine

/// Get pokemon species data UseCase interface
protocol GetPokemonSpeciesUseCase {
  /// Performs request asynchronously with propagating result pokemon species through AnyPublisher
  func invoke(_ pokemonId: String) -> AnyPublisher<PokemonSpecies?, Error>
}
