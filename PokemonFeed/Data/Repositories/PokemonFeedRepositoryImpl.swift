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
  private let pokemonFeedStorage: PokemonFeedStorage
  
  // MARK: - Constructor
  
  init(
    networkService: NetworkService,
    pokemonFeedStorage: PokemonFeedStorage
  ) {
    self.networkService = networkService
    self.pokemonFeedStorage = pokemonFeedStorage
  }
  
  // MARK: - Functions
  
  func getPokemonFeed() -> AnyPublisher<[Pokemon], Error> {
    pokemonFeedStorage.getPokemonFeed()
      .tryCatch { [weak self, pokemonFeedStorage] _ -> AnyPublisher<[Pokemon], Error> in
        guard let self = self else {
          return Empty<[Pokemon], Error>().eraseToAnyPublisher()
        }
        
        return self.getPokemonFeedFromNetwork()
          .handleEvents(receiveOutput: pokemonFeedStorage.save(pokemonFeed:))
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
  
  // MARK: - Private functions
  
  private func getPokemonFeedFromNetwork() -> AnyPublisher<[Pokemon], Error> {
    networkService.request(
      urlRequest: PokemonFeedApiEndpoint.getTotalCount.urlRequest(baseURL:))
      .tryMap(PokemonFeedTotalCountResultMapper.map)
      .flatMap { [networkService] totalCount in
        networkService.request(
          urlRequest: PokemonFeedApiEndpoint.getPokemonFeed(limit: totalCount).urlRequest(baseURL:))
          .tryMap(PokemonFeedResultMapper.map)
          .map(\.pokemons)
      }
      .eraseToAnyPublisher()
  }
}
