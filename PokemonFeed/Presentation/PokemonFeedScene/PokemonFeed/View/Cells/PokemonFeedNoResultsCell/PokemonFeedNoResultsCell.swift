//
//  PokemonFeedNoResultsCell.swift
//  PokemonFeed
//
//  Created by Valeriy L on 19.09.2022.
//

import UIKit

final class PokemonFeedNoResultsCellModel: BaseTableCellModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PokemonFeedNoResultsCell.self
  }
  
  let title: String
  
  // MARK: - Constructor
  
  init() {
    title = NSLocalizedString("No results were found.", comment: "")
    super.init()
  }
}

final class PokemonFeedNoResultsCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  // MARK: - Functions
  
  // With empty body disables cell highlighting while tapping on it
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PokemonFeedNoResultsCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    titleLabel.text = model.title
  }
}
