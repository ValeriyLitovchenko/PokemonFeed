//
//  GetPokemonFeedUseCaseMOC.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Foundation
import Combine

struct GetPokemonFeedUseCaseMOC: GetPokemonFeedUseCase {
  func invoke() -> AnyPublisher<[Pokemon], Error> {
    Deferred {
      Future { promise in
        let pokemons = stride(from: 1, to: 23, by: 1)
          .map(PokemonMOCItem.init(iteration:))
        promise(.success(pokemons))
      }
    }
    .eraseToAnyPublisher()
  }
}

private struct PokemonMOCItem: Pokemon {
  
  // MARK: - Property
  
  let id: String
  let name: String
  let sprite: String
  
  // MARK: - Constructor
  
  init(iteration: Int) {
    id = "\(iteration)"
    name = "Pokemon \(iteration)"
    sprite = ""
  }
}
