//
//  AppDIContainer.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Foundation

final class AppDIContainer {
  
  // MARK: - DIContainers of scenes
  
  var pokemonFeedSceneDependencies: PokemonFeedSceneDIContainer {
    PokemonFeedSceneDIContainer()
  }
}
