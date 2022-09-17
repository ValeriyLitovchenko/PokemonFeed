//
//  PokemonDetailsViewModelImpl.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

final class PokemonDetailsViewModelImpl: BaseTableViewViewModel, PokemonDetailsViewModel {
  
  // MARK: - Property
  
  let screenTitle: String
  
  var reloadContent: VoidCallback?
  
  private let pokemonId: String
  
  // MARK: - Constructor
  
  init(inputModel: PokemonDetailsInput) {
    screenTitle = inputModel.pokemonName
    pokemonId = inputModel.pokemonId
  }
  
  // MARK: - Functions
  
  func loadData() {
    
  }
  
}
