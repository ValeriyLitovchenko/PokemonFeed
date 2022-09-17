//
//  InMemoryPokemonFeedStorage.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation
import Combine

final class InMemoryPokemonFeedStorage: PokemonFeedStorage {
  
  private enum Error: Swift.Error {
    case noItemsStored
  }
  
  // MARK: - Properties
  
  private var pokemonFeed: [Pokemon]?
  
  // MARK: - Functions
  
  func getPokemonFeed(for request: PokemonFeedRequestDTO?) -> AnyPublisher<[Pokemon], Swift.Error> {
    guard let pokemonFeed = self.pokemonFeed else {
      return Fail(
        outputType: [Pokemon].self,
        failure: InMemoryPokemonFeedStorage.Error.noItemsStored)
      .eraseToAnyPublisher()
    }
    
    guard let query = request?.query.lowercased() else {
      return Just(pokemonFeed)
        .setFailureType(to: Swift.Error.self)
        .eraseToAnyPublisher()
    }
    
    return Deferred {
      Future { promise in
        let filtered = pokemonFeed.filter { $0.name.hasPrefix(query) }
        promise(.success(filtered))
      }
    }
    .subscribe(on: DispatchQueue.global(qos: .userInitiated))
    .eraseToAnyPublisher()
  }
  
  func save(pokemonFeed: [Pokemon]) {
    self.pokemonFeed = pokemonFeed
  }
}
