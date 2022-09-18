//
//  GetPokemonDetailsUseCaseImpl.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Combine

struct GetPokemonDetailsUseCaseImpl: GetPokemonDetailsUseCase {
  let networkService: NetworkService
  
  func invoke(_ pokemonId: String) -> AnyPublisher<PokemonDetails, Error> {
    let endpoint = PokemonDetailsApiEndpoint.getPokemonDetails(id: pokemonId)
    
    return networkService.request(urlRequest: endpoint.urlRequest(baseURL:))
      .tryMap(PokemonDetailsResultMapper.map)
      .eraseToAnyPublisher()
  }
}
