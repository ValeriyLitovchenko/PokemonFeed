//
//  InMemoryPokemonFeedStorage.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Combine

final class InMemoryPokemonFeedStorage: PokemonFeedStorage {
  
  private enum Error: Swift.Error {
    case noItemsStored
  }
  
  // MARK: - Properties
  
  private var pokemonFeed: [Pokemon]?
  
  // MARK: - Functions
  
  func getPokemonFeed() -> AnyPublisher<[Pokemon], Swift.Error> {
    guard let pokemonFeed = self.pokemonFeed else {
      return Fail(
        outputType: [Pokemon].self,
        failure: InMemoryPokemonFeedStorage.Error.noItemsStored)
      .eraseToAnyPublisher()
    }
    
    return Just(pokemonFeed)
      .setFailureType(to: Swift.Error.self)
      .eraseToAnyPublisher()
  }
  
  func save(pokemonFeed: [Pokemon]) {
    self.pokemonFeed = pokemonFeed
  }
}
