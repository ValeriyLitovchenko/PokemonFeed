//
//  GetPokemonSpeciesUseCase.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Combine

protocol GetPokemonSpeciesUseCase {
  func invoke(_ pokemonId: String) -> AnyPublisher<PokemonSpecies?, Error>
}
