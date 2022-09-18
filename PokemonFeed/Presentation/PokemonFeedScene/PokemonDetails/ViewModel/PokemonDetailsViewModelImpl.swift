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
  private let getPokemonSpeciesUseCase: GetPokemonSpeciesUseCase
  
  private var cancelable: Cancellable?
  
  // MARK: - Constructor
  
  init(
    inputModel: PokemonDetailsInputModel,
    getPokemonDetailsUseCase: GetPokemonDetailsUseCase,
    getPokemonSpeciesUseCase: GetPokemonSpeciesUseCase
  ) {
    screenTitle = inputModel.pokemonName
    pokemonId = inputModel.pokemonId
    self.getPokemonDetailsUseCase = getPokemonDetailsUseCase
    self.getPokemonSpeciesUseCase = getPokemonSpeciesUseCase
  }
  
  // MARK: - Functions
  
  func loadData() {
    cancelable = Publishers.Zip(
      getPokemonDetailsUseCase.invoke(pokemonId),
      getPokemonSpeciesUseCase.invoke(pokemonId))
      .sink(
        receiveCompletion: { _ in
          
        }, receiveValue: { [weak self] details, species in
          guard let self = self else { return }
          
          let content = self.buildContent(with: details, species: species)
          self.updateContent(with: content)
          self.reloadContent?()
        })
  }
  
  // MARK: - Private functions
  
  private func buildContent(
    with details: PokemonDetails,
    species: PokemonSpecies?
  ) -> [TableSectionModel] {
    [
      buildImageSection(details),
      buildAttributesSection(details),
      buildAbilitiesSection(details),
      buildSpeciesSection(species)
    ].compactMap { $0 }
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
  
  private func buildAbilitiesSection(_ details: PokemonDetails) -> TableSectionModel {
    let items = [
      PokemonDetailsSectionTitleCellViewModel(
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
      PokemonDetailsSectionTitleCellViewModel(
        title: NSLocalizedString("Species", comment: "")),
      
      PokemonDetailsAttributeCellViewModel(
        name: NSLocalizedString("Generation:", comment: ""),
        value: species.generation),
      
      PokemonDetailsAttributeCellViewModel(
        name: NSLocalizedString("Growth Rate:", comment: ""),
        value: species.growthRate),
      
      PokemonDetailsAttributeCellViewModel(
        name: NSLocalizedString("Habitat:", comment: ""),
        value: species.habitat)
    ]
    
    return TableSectionModel(items: items)
  }
}
