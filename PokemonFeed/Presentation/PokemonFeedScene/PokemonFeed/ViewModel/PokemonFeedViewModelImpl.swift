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
  var onStateChange: ValueCallback<PokemonFeedViewModelState>?
  
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
      .handleEvents(receiveSubscription: { [weak self] _ in
          self?.onStateChange?(.loading)
        })
      .sink(receiveCompletion: { [weak self] completion in
        guard let self = self else { return }
        
        switch completion {
        case .finished:
          self.onStateChange?(.dataLoaded)
        case .failure:
          self.onStateChange?(.error)
        }
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
