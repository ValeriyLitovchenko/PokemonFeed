//
//  PokemonDetailsViewModelImpl.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation
import Combine

final class PokemonDetailsViewModelImpl: BaseTableViewViewModel, PokemonDetailsViewModel {
  private enum Constants {
    static let maxLoadDataOnErrorRetriesCount = 2
  }
  
  // MARK: - Properties
  
  let screenTitle: String
  
  var reloadContent: VoidCallback?
  var onStateChange: ValueCallback<PokemonDetailsViewModelState>?
  
  private let pokemonId: String
  
  private let getPokemonDetailsUseCase: GetPokemonDetailsUseCase
  private let getPokemonSpeciesUseCase: GetPokemonSpeciesUseCase
  private let navigationActions: PokemonDetailsNavigationActions
  
  private var cancelable: Cancellable?
  
  private var loadDataOnErrorRetriesCount = Int.zero
  private var canShowLoadDataErrorMessage: Bool {
    loadDataOnErrorRetriesCount < PokemonDetailsViewModelImpl.Constants.maxLoadDataOnErrorRetriesCount
  }
  // MARK: - Constructor
  
  init(
    inputModel: PokemonDetailsInputModel,
    getPokemonDetailsUseCase: GetPokemonDetailsUseCase,
    getPokemonSpeciesUseCase: GetPokemonSpeciesUseCase,
    navigationActions: PokemonDetailsNavigationActions
  ) {
    screenTitle = inputModel.pokemonName
    pokemonId = inputModel.pokemonId
    self.getPokemonDetailsUseCase = getPokemonDetailsUseCase
    self.getPokemonSpeciesUseCase = getPokemonSpeciesUseCase
    self.navigationActions = navigationActions
  }
  
  // MARK: - Functions
  
  func loadData() {
    cancelable = Publishers.Zip(
      getPokemonDetailsUseCase.invoke(pokemonId),
      getPokemonSpeciesUseCase.invoke(pokemonId))
    .handleEvents(receiveSubscription: { [weak self] _ in
      self?.onStateChange?(.loading)
    })
    .sink(receiveCompletion: { [weak self] completion in
      guard let self = self else { return }
      
      switch completion {
      case .finished:
        self.onStateChange?(.dataLoaded)
        self.loadDataOnErrorRetriesCount = .zero
        
      case .failure:
        self.onStateChange?(.error)
        if self.canShowLoadDataErrorMessage {
          self.loadDataOnErrorRetriesCount += 1
          DispatchQueue.main.async { [weak self] in
            self?.showLoadDataErrorMessage()
          }
        }
      }
    }, receiveValue: { [weak self] details, species in
      guard let self = self else { return }
      
      let content = self.buildContent(with: details, species: species)
      self.updateContent(with: content)
      self.reloadContent?()
    })
  }
  
  // MARK: - Private functions
  
  private func showLoadDataErrorMessage() {
    let messageModel = FetchingDataErrorMessageAlertModel.modelWithActions(
      onRetry: { [weak self] in
        self?.loadData()
      }, onCancel: { [weak self] in
        self?.navigationActions.close()
      })
    
    navigationActions.showMessage(messageModel)
  }
  
  private func buildContent(
    with details: PokemonDetails,
    species: PokemonSpecies?
  ) -> [TableSectionModel] {
    [
      buildImageSection(details),
      buildAttributesSection(details),
      buildAbilitiesSection(details),
      buildSpeciesSection(species),
      buildVarietiesSection(species?.varieties)
    ].compactMap { $0 }
  }
  
  private func buildImageSection(_ details: PokemonDetails) -> TableSectionModel {
    let items = [
      PokemonDetailsImageCellModel(sprite: details.sprite)
    ]
    
    return TableSectionModel(items: items)
  }
  
  private func buildAttributesSection(_ details: PokemonDetails) -> TableSectionModel {
    let items = [
      PokemonDetailsSectionTitleCellModel(
        title: NSLocalizedString("Attributes", comment: "")),
      
      PokemonDetailsAttributeCellModel(
        name: NSLocalizedString("Height", comment: "") + ":",
        value: "\(details.height)"),
      
      PokemonDetailsAttributeCellModel(
        name: NSLocalizedString("Weight", comment: "") + ":",
        value: "\(details.weight)")
    ]
    
    return TableSectionModel(items: items)
  }
  
  private func buildAbilitiesSection(_ details: PokemonDetails) -> TableSectionModel {
    let items = [
      PokemonDetailsSectionTitleCellModel(
        title: NSLocalizedString("Abilities", comment: "")),
      
      PokemonDetailsAbilitiesCellModel(
        abilities: details.abilities.joined(separator: ", "))
    ]
    
    return TableSectionModel(items: items)
  }
  
  private func buildSpeciesSection(_ species: PokemonSpecies?) -> TableSectionModel? {
    guard let species = species else {
      return nil
    }
    
    let items = [
      PokemonDetailsSectionTitleCellModel(
        title: NSLocalizedString("Species", comment: "")),
      
      PokemonDetailsAttributeCellModel(
        name: NSLocalizedString("Generation:", comment: ""),
        value: species.generation),
      
      PokemonDetailsAttributeCellModel(
        name: NSLocalizedString("Growth Rate:", comment: ""),
        value: species.growthRate),
      
      PokemonDetailsAttributeCellModel(
        name: NSLocalizedString("Habitat:", comment: ""),
        value: species.habitat)
    ]
    
    return TableSectionModel(items: items)
  }
  
  private func buildVarietiesSection(_ varieties: [PokemonVariety]?) -> TableSectionModel? {
    guard let varieties = varieties?.filter({ $0.id != pokemonId }),
            !varieties.isEmpty else {
      return nil
    }

    var items: [BaseTableCellModel] = [
      PokemonDetailsSectionTitleCellModel(
        title: NSLocalizedString("Varieties", comment: "")
      )
    ]
    
    varieties.forEach { variety in
      items.append(
        PokemonVarietyCellModel(
          title: variety.name,
          sprite: variety.sprite,
          onAction: { [weak self] in
            self?.navigationActions.openVarietyDetails(
              PokemonDetailsInputModel(
                pokemonId: variety.id,
                pokemonName: variety.name.firstUppercased))
          })
      )
    }
    
    return TableSectionModel(items: items)
  }
}
