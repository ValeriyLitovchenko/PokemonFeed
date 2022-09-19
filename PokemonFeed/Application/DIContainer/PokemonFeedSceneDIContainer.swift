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
  
  private var getPokemonFeedUseCase: GetPokemonFeedUseCase {
    GetPokemonFeedUseCaseImpl(
      pokemonFeedRepository: PokemonFeedRepositoryImpl(
        networkService: dependencies.networkService,
        pokemonFeedStorage: InMemoryPokemonFeedStorage()))
  }
  
  private var getPokemonDetailsUseCase: GetPokemonDetailsUseCase {
    GetPokemonDetailsUseCaseImpl(networkService: dependencies.networkService)
  }
  
  private var getPokemonSpeciesUseCase: GetPokemonSpeciesUseCase {
    GetPokemonSpeciesUseCaseImpl(networkService: dependencies.networkService)
  }
  
  // MARK: - Flow Coordinators
  
  func makePokemonFeedSceneFlowCoordinator(navigationController: UINavigationController) -> PokemonFeedSceneFlowCoordinator {
    PokemonFeedSceneFlowCoordinator(
      navigationController: navigationController,
      dependencies: self)
  }
}

extension PokemonFeedSceneDIContainer: PokemonFeedSceneFlowCoordinatorDependencies {
  func makePokemonFeedController(actions: PokemonFeedNavigationActions) -> UIViewController {
    let viewModel = PokemonFeedViewModelImpl(
      getPokemonFeedUseCase: getPokemonFeedUseCase,
      navigationActions: actions)
    
    return PokemonFeedController(viewModel: viewModel)
  }
  
  func makePokemonDetailsController(
    inputModel: PokemonDetailsInputModel,
    navigationActions: PokemonDetailsNavigationActions
  ) -> UIViewController {
    let viewModel = PokemonDetailsViewModelImpl(
      inputModel: inputModel,
      getPokemonDetailsUseCase: getPokemonDetailsUseCase,
      getPokemonSpeciesUseCase: getPokemonSpeciesUseCase,
      navigationActions: navigationActions)
    
    return PokemonDetailsController(viewModel: viewModel)
  }
}
