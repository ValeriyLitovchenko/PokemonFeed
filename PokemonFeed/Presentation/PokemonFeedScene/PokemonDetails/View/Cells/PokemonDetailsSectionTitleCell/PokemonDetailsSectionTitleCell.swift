//
//  PokemonDetailsSectionTitleCell.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import UIKit

final class PokemonDetailsSectionTitleCellViewModel: BaseTableCellModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PokemonDetailsSectionTitleCell.self
  }
  
  let title: String
  
  // MARK: Constructor
  
  init(title: String) {
    self.title = title
  }
}

final class PokemonDetailsSectionTitleCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var sectionTitleLabel: UILabel!
  
  // MARK: - Functions
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PokemonDetailsSectionTitleCellViewModel else {
      fatalError("Wrong item provided to cell")
    }
    
    sectionTitleLabel.text = model.title
  }
}
