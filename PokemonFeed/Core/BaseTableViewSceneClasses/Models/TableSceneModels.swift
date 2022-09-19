//
//  TableSceneModels.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import Foundation

/// A generic object which contains all required info to setup UI for one table view section
class SectionModel<C: CellModel> {
  
  // MARK: - Properties
  
  let items: [C]
  
  // MARK: - Constructor
  
  init(items: [C]) {
    self.items = items
  }
}

/**
 In general each cell has it's own cell object.
 All cells must inherit from base abstract classes.
 */
protocol CellModel {
  associatedtype ReusableCellType
  
  var type: ReusableCellType { get }
}
