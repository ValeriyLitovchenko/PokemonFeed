//
//  PokemonFeedSceneDIContainer.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

final class PokemonFeedSceneDIContainer {
  
  // MARK: - UseCases
  
  var getPokemonFeedUseCase: GetPokemonFeedUseCase {
    GetPokemonFeedUseCaseMOC()
  }
  
  // MARK: - Flow Coordinators
  
  func makePokemonFeedSceneFlowCoordinator(navigationController: UINavigationController) -> PokemonFeedSceneFlowCoordinator {
    PokemonFeedSceneFlowCoordinator(
      navigationController: navigationController,
      dependencies: self)
  }
}

extension PokemonFeedSceneDIContainer: PokemonFeedSceneFlowCoordinatorDependencies {
  func makePokemonFeedController() -> UIViewController {
    let viewModel = PokemonFeedViewModelImpl(getPokemonFeedUseCase: getPokemonFeedUseCase)
    return PokemonFeedController(viewModel: viewModel)
  }
}
