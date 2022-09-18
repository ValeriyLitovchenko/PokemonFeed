//
//  PokemonDetailsViewModelImpl.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation
import Combine

final class PokemonDetailsViewModelImpl: BaseTableViewViewModel, PokemonDetailsViewModel {
  
  // MARK: - Property
  
  let screenTitle: String
  
  var reloadContent: VoidCallback?
  
  private let pokemonId: String
  
  private let getPokemonDetailsUseCase: GetPokemonDetailsUseCase
  
  private var cancelable: Cancellable?
  
  // MARK: - Constructor
  
  init(
    inputModel: PokemonDetailsInputModel,
    getPokemonDetailsUseCase: GetPokemonDetailsUseCase
  ) {
    screenTitle = inputModel.pokemonName
    pokemonId = inputModel.pokemonId
    self.getPokemonDetailsUseCase = getPokemonDetailsUseCase
  }
  
  // MARK: - Functions
  
  func loadData() {
    cancelable = getPokemonDetailsUseCase.invoke(pokemonId)
      .sink(
        receiveCompletion: { _ in
          
        }, receiveValue: { [weak self] details in
          guard let self = self else { return }
          
          let content = self.buildContent(with: details)
          self.updateContent(with: content)
          self.reloadContent?()
        })
  }
  
  // MARK: - Private functions
  
  private func buildContent(with details: PokemonDetails) -> [TableSectionModel] {
    [
      buildImageSection(details),
      buildAttributesSection(details)
    ]
  }
  
  private func buildImageSection(_ details: PokemonDetails) -> TableSectionModel {
    let items = [
      PokemonDetailsImageCellViewModel(sprite: details.sprite)
    ]
    return TableSectionModel(items: items)
  }
  
  private func buildAttributesSection(_ details: PokemonDetails) -> TableSectionModel {
    let items = [
      PokemonDetailsSectionTitleCellViewModel(
        title: NSLocalizedString("Attributes", comment: "")),
      
      PokemonDetailsAttributeCellViewModel(
        name: NSLocalizedString("Height", comment: "") + ":",
        value: "\(details.height)"),
      
      PokemonDetailsAttributeCellViewModel(
        name: NSLocalizedString("Weight", comment: "") + ":",
        value: "\(details.weight)")
    ]
    return TableSectionModel(items: items)
  }
}
