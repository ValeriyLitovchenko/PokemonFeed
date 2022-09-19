//
//  PokemonFeedSceneDIContainer.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

/// Container for PokemonFeedScene dependencies
final class PokemonFeedSceneDIContainer {
  
  /// PokemonFeedScene dependencies
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
  
  /// Instantiates `GetPokemonFeedUseCase` for fetching pokemons
  private var getPokemonFeedUseCase: GetPokemonFeedUseCase {
    GetPokemonFeedUseCaseImpl(
      pokemonFeedRepository: PokemonFeedRepositoryImpl(
        networkService: dependencies.networkService,
        pokemonFeedStorage: InMemoryPokemonFeedStorage()))
  }
  
  /// Instantiates `GetPokemonDetailsUseCase` for fetching pokemon details
  private var getPokemonDetailsUseCase: GetPokemonDetailsUseCase {
    GetPokemonDetailsUseCaseImpl(networkService: dependencies.networkService)
  }
  
  /// Instantiates `GetPokemonDetailsUseCase` for fetching pokemon species
  private var getPokemonSpeciesUseCase: GetPokemonSpeciesUseCase {
    GetPokemonSpeciesUseCaseImpl(networkService: dependencies.networkService)
  }
  
  // MARK: - Flow Coordinators
  
  /// Instantiates `PokemonFeedSceneFlowCoordinator` with `navigationController`
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
