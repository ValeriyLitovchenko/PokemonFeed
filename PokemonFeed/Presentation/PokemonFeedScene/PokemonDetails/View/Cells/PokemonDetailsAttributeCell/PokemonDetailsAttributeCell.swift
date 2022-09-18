//
//  PokemonDetailsAttributeCell.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import UIKit

final class PokemonDetailsAttributeCellViewModel: BaseTableCellModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PokemonDetailsAttributeCell.self
  }
  
  let name: String
  let value: String
  
  // MARK: - Constructor
  
  init(name: String, value: String) {
    self.name = name
    self.value = value
  }
}

final class PokemonDetailsAttributeCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var attributeNameLabel: UILabel!
  @IBOutlet private weak var attributeValueLabel: UILabel!
  
  // MARK: - Functions
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PokemonDetailsAttributeCellViewModel else {
      fatalError("Wrong item provided to cell")
    }
    
    attributeNameLabel.text = model.name
    attributeValueLabel.text = model.value
  }
}
