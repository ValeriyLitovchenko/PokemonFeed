//
//  PokemonFeedViewModel.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Foundation

protocol PokemonFeedViewModel: BaseTableViewViewModelProtocol {
  var screenTitle: String { get }
  var searchBarPlaceholder: String { get }
  var reloadContent: VoidCallback? { get set }
  var onStateChange: ValueCallback<PokemonFeedViewModelState>? { get set }
  
  func loadData()
  func performSearch(with query: String?)
}

enum PokemonFeedViewModelState {
  case loading
  case dataLoaded
  case error
}
