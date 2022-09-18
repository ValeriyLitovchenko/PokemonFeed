//
//  PokemonFeedSceneFlowCoordinator.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

protocol PokemonFeedSceneFlowCoordinatorDependencies {
  func makePokemonFeedController(actions: PokemonFeedNavigationActions) -> UIViewController
  func makePokemonDetailsController(inputModel: PokemonDetailsInputModel) -> UIViewController
}

final class PokemonFeedSceneFlowCoordinator {
  
  // MARK: - Properties
  
  private weak var navigationController: UINavigationController?
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
    let pokemonFeedActions = PokemonFeedNavigationActions(openDetails: openPokemonDetails(with:))
    let viewController = dependencies.makePokemonFeedController(actions: pokemonFeedActions)
    navigationController?.viewControllers = [viewController]
  }
  
  // MARK: - Private functions
  
  private func openPokemonDetails(with detailsInputModel: PokemonDetailsInputModel) {
    let viewController = dependencies.makePokemonDetailsController(inputModel: detailsInputModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
}
