//
//  PokemonFeedItemCell.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

final class PokemonFeedItemCellModel: BaseTableCellModel, ApplicableActionModel {
  
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
  
  private var model: PokemonFeedItemCellModel?
  
  // MARK: - Public Functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setSelectionBackgroundColor(DefinedColors.lightCellSelectionColor.color)
  }
  
  override func configure(with model: BaseTableCellModel) {
    
    guard let model = model as? PokemonFeedItemCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    self.model = model
    
    pokemonTitleLabel.text = model.title
    pokemonSpriteView.setImage(
      with: model.sprite,
      noImagePlaceholder: DefinedImages.pokeball.image)
  }
}
