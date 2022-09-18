//
//  PokemonDetailsViewModel.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

protocol PokemonDetailsViewModel: BaseTableViewViewModelProtocol {
  var screenTitle: String { get }
  var reloadContent: VoidCallback? { get set }
  var onStateChange: ValueCallback<PokemonDetailsViewModelState>? { get set }
  
  func loadData()
}

enum PokemonDetailsViewModelState {
  case loading
  case dataLoaded
  case error
}
