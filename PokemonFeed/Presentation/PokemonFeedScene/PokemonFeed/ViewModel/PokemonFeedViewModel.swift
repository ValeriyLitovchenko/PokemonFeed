//
//  PokemonFeedViewModel.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Foundation

protocol PokemonFeedViewModel: BaseTableViewViewModelProtocol {
  var screenTitle: String { get }
  var reloadContent: VoidCallback? { get set }
  
  func loadData()
}
