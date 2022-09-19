//
//  PokemonFeedSceneFlowCoordinator.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

protocol PokemonFeedSceneFlowCoordinatorDependencies: MessageAlertFactory {
  func makePokemonFeedController(actions: PokemonFeedNavigationActions) -> UIViewController
  func makePokemonDetailsController(
    inputModel: PokemonDetailsInputModel,
    navigationActions: PokemonDetailsNavigationActions
  ) -> UIViewController
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
    let pokemonFeedActions = PokemonFeedNavigationActions(
      openDetails: openPokemonDetails(with:),
      showMessage: showMessage(with:)
    )
    let viewController = dependencies.makePokemonFeedController(actions: pokemonFeedActions)
    navigationController?.viewControllers = [viewController]
  }
  
  // MARK: - Private functions
  
  private func openPokemonDetails(with detailsInputModel: PokemonDetailsInputModel) {
    let pokemonFeedActions = PokemonDetailsNavigationActions(
      openVarietyDetails: openPokemonDetails(with:),
      showMessage: showMessage(with:),
      close: { [weak navigationController] in
        navigationController?.popViewController(animated: true)
      })
    
    let viewController = dependencies.makePokemonDetailsController(
      inputModel: detailsInputModel,
      navigationActions: pokemonFeedActions)
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  private func showMessage(with model: MessageAlertModel) {
    let messageAlert = dependencies.makeMessageAlert(with: model)
    navigationController?.present(messageAlert, animated: true)
  }
}
