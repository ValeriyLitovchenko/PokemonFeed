//
//  AppDIContainer.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Foundation

final class AppDIContainer {
  
  // MARK: - Properties
  
  private lazy var networkService: NetworkService = RestApiNetworkService(
    // swiftlint:disable force_unwrapping
    baseURL: URL(string: AppConstants.apiBaseURLString)!,
    httpClient: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)))
  
  // MARK: - DIContainers of scenes
  
  var pokemonFeedSceneDependencies: PokemonFeedSceneDIContainer {
    PokemonFeedSceneDIContainer(networkService: networkService)
  }
}
