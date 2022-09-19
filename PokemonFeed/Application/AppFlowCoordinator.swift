//
//  AppFlowCoordinator.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

/// An object that operates with main application flow transitions between scenes
final class AppFlowCoordinator {
  
  // MARK: - Properties
  
  let navigationController: UINavigationController
  private let appDIContainer = AppDIContainer()
  
  // MARK: - Constructor
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Functions
  
  func start() {
    let flow = appDIContainer.pokemonFeedSceneDependencies
      .makePokemonFeedSceneFlowCoordinator(navigationController: navigationController)
    flow.start()
  }
}
