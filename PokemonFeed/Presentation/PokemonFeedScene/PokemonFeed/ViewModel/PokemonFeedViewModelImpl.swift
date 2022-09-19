//
//  PokemonFeedViewModelImpl.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Foundation
import Combine

final class PokemonFeedViewModelImpl: BaseTableViewViewModel, PokemonFeedViewModel {
  private enum Constants {
    static let searchOperationDelay = RunLoop.SchedulerTimeType.Stride(0.18)
  }
  
  // MARK: - Properties
  
  let screenTitle = NSLocalizedString("Pokemons", comment: "")
  let searchBarPlaceholder = NSLocalizedString("Enter pokemon name", comment: "")
    
  var reloadContent: VoidCallback?
  var onStateChange: ValueCallback<PokemonFeedViewModelState>?
  
  private let getPokemonFeedUseCase: GetPokemonFeedUseCase
  private let actions: PokemonFeedNavigationActions
  private var cancellable: Cancellable?
  
  // MARK: - Constructor
  
  init(
    getPokemonFeedUseCase: GetPokemonFeedUseCase,
    actions: PokemonFeedNavigationActions
  ) {
    self.getPokemonFeedUseCase = getPokemonFeedUseCase
    self.actions = actions
  }
  
  // MARK: - Functions
  
  func loadData() {
    performSearch()
  }
  
  func performSearch(with query: String? = nil) {
    cancellable?.cancel()
    
    let getFeedOperation: AnyPublisher<[Pokemon], Error>
    if let query = query {
      getFeedOperation = Just(PokemonFeedQuery(value: query))
        .setFailureType(to: Error.self)
        .delay(
          for: PokemonFeedViewModelImpl.Constants.searchOperationDelay,
          scheduler: RunLoop.main)
        .flatMap { [getPokemonFeedUseCase] query in
          getPokemonFeedUseCase.invoke(query: query)
        }
        .eraseToAnyPublisher()
    } else {
       getFeedOperation = getPokemonFeedUseCase.invoke(query: nil)
    }
    
    cancellable = getFeedOperation
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
    let items: [BaseTableCellModel]
    if pokemons.isEmpty {
      items = [PokemonFeedNoResultsCellModel()]
    } else {
      items = pokemons.map { pokemon in
       PokemonFeedItemCellViewModel(
         title: pokemon.name.firstUppercased,
         sprite: pokemon.sprite,
         onAction: { [actions] in
           actions.openDetails(PokemonDetailsInputModel(
             pokemonId: pokemon.id,
             pokemonName: pokemon.name.firstUppercased))
         })
     }
    }
    
    return [TableSectionModel(items: items)]
  }
}
