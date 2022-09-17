//
//  PokemonFeedSceneFlowCoordinator.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

protocol PokemonFeedSceneFlowCoordinatorDependencies {
  func makePokemonFeedController(actions: PokemonFeedNavigationActions) -> UIViewController
  func makePokemonDetailsController(inputModel: PokemonDetailsInput) -> UIViewController
}

final class PokemonFeedSceneFlowCoordinator {
  
  // MARK: - Properties
  
  private let navigationController: UINavigationController
  private let dependencies: PokemonFeedSceneFlowCoordinatorDependencies
  
  // MARK: - Constructor
  
  init(
    navigationController: UINavigationController,
    dependencies: PokemonFeedSceneFlowCoordinatorDependencies
  ) {
    self.navigationController = navigationController
    self.dependencies = dependencies
  }
  
  // MARK: - Functions
  
  func start() {
    let viewController = dependencies.makePokemonFeedController()
    navigationController.viewControllers = [viewController]
  }
}
