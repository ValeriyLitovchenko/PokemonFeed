//
//  PokemonFeedViewModelImpl.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Foundation
import Combine

final class PokemonFeedViewModelImpl: BaseTableViewViewModel, PokemonFeedViewModel {
  
  // MARK: - Properties
  
  let screenTitle = NSLocalizedString("Pokemons", comment: "")
  
  var reloadContent: VoidCallback?
  
  private let getPokemonFeedUseCase: GetPokemonFeedUseCase
  private var cancellable: Cancellable?
  
  // MARK: - Constructor
  
  init(getPokemonFeedUseCase: GetPokemonFeedUseCase) {
    self.getPokemonFeedUseCase = getPokemonFeedUseCase
  }
  
  // MARK: - Functions
  
  func loadData() {
    cancellable?.cancel()
    
    cancellable = getPokemonFeedUseCase.invoke()
      .sink(receiveCompletion: { _ in
        
      }, receiveValue: { [weak self] pokemons in
        guard let self = self else { return }
        
        self.updateContent(with: self.buildContent(pokemons))
        self.reloadContent?()
      })
  }
  
  // MARK: - Private functions
  
  private func buildContent(_ pokemons: [Pokemon]) -> TableViewViewModelContent {
    let items = pokemons.map { pokemon in
      PokemonFeedItemCellViewModel(
        title: pokemon.name,
        sprite: pokemon.sprite,
        onAction: {})
    }
    
    return [TableSectionModel(items: items)]
  }
}
