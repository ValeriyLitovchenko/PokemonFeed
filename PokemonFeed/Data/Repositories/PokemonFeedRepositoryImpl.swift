//
//  PokemonFeedRepositoryImpl.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Combine

final class PokemonFeedRepositoryImpl: PokemonFeedRepository {
  
  // MARK: - Properties
  
  private let networkService: NetworkService
  
  // MARK: - Constructor
  
  init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
  // MARK: - Functions
  
  func getPokemonFeed() -> AnyPublisher<[Pokemon], Error> {
    let apiEndpoint = GetPokemonFeedApiEndpoint(
      limit: 2000,
      offset: .zero)
    
    return networkService.request(urlRequest: apiEndpoint.urlRequest(baseURL:))
      .tryMap(PokemonFeedResultMapper.map)
      .map(\.pokemons)
      .eraseToAnyPublisher()
  }
}
