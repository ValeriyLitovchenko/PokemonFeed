//
//  GetPokemonSpeciesUseCaseImpl.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Combine

struct GetPokemonSpeciesUseCaseImpl: GetPokemonSpeciesUseCase {
  let networkService: NetworkService
  
  func invoke(_ pokemonId: String) -> AnyPublisher<PokemonSpecies?, Error> {
    let endpoint = PokemonSpeciesApiEndpoint.getPokemonSpecies(id: pokemonId)
    
    return networkService.request(urlRequest: endpoint.urlRequest(baseURL:))
      .tryMap(PokemonSpeciesResultMapper.map)
      .eraseToAnyPublisher()
  }
}
