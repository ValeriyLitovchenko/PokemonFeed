//
//  PokemonFeedItemCell.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

final class PokemonFeedItemCellViewModel: BaseTableCellModel, ApplicableActionModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PokemonFeedItemCell.self
  }
  
  let title: String
  let sprite: String
  let onAction: VoidCallback
  
  // MARK: - Constructor
  
  init(
    title: String,
    sprite: String,
    onAction: @escaping VoidCallback
  ) {
    self.title = title
    self.sprite = sprite
    self.onAction = onAction
  }
}

final class PokemonFeedItemCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var pokemonTitleLabel: UILabel!
  @IBOutlet private weak var pokemonSpriteView: UIImageView!
  
  // MARK: - Properties
  
  private var model: PokemonFeedItemCellViewModel?
  
  // MARK: - Public Functions
  
  override func configure(with model: BaseTableCellModel) {
    
    guard let model = model as? PokemonFeedItemCellViewModel else {
      fatalError("Wrong item provided to cell")
    }
    
    self.model = model
    
    pokemonTitleLabel.text = model.title
  }
}