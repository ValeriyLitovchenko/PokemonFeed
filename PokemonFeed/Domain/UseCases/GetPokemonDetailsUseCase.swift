//
//  GetPokemonDetailsUseCase.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Combine

protocol GetPokemonDetailsUseCase {
  func invoke(_ pokemonId: String) -> AnyPublisher<PokemonDetails, Error>
}
