//
//  PokemonFeedSceneDIContainer.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

final class PokemonFeedSceneDIContainer {
  
  private struct Dependencies {
    let networkService: NetworkService
  }
  
  // MARK: - Properties
  
  private let dependencies: Dependencies
  
  // MARK: - Constructor
  
  init(networkService: NetworkService) {
    dependencies = Dependencies(networkService: networkService)
  }
  
  // MARK: - UseCases
  
  var getPokemonFeedUseCase: GetPokemonFeedUseCase {
    GetPokemonFeedUseCaseImpl(
      pokemonFeedRepository: PokemonFeedRepositoryImpl(
        networkService: dependencies.networkService,
        pokemonFeedStorage: InMemoryPokemonFeedStorage()))
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
  
  func makePokemonDetailsController(with inputModel: PokemonDetailsInput) -> UIViewController {
    let viewModel = PokemonDetailsViewModelImpl(inputModel: inputModel)
    return PokemonDetailsController(viewModel: viewModel)
  }
}
