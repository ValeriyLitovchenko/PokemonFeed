//
//  PokemonDetailsAbilitiesCell.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import UIKit

final class PokemonDetailsAbilitiesCellModel: BaseTableCellModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PokemonDetailsAbilitiesCell.self
  }
  
  let abilities: String
  
  // MARK: - Constructor
  
  init(abilities: String) {
    self.abilities = abilities
  }
}

final class PokemonDetailsAbilitiesCell: BaseTableCell {
  
  // MARK: - Outlet
  
  @IBOutlet private weak var abilitiesLabel: UILabel!
  
  // MARK: - Functions
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PokemonDetailsAbilitiesCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    abilitiesLabel.text = model.abilities
  }
}
