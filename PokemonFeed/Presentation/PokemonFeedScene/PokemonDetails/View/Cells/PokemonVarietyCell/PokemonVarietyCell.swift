//
//  PokemonVarietyCell.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import UIKit

final class PokemonVarietyCellModel: BaseTableCellModel, ApplicableActionModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PokemonVarietyCell.self
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

final class PokemonVarietyCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var varietyTitleLabel: UILabel!
  @IBOutlet private weak var varietySpriteView: UIImageView!
  
  // MARK: - Public Functions
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setSelectionBackgroundColor(DefinedColors.lightCellSelectionColor.color)
  }
  
  override func configure(with model: BaseTableCellModel) {
    
    guard let model = model as? PokemonVarietyCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    varietyTitleLabel.text = model.title
    varietySpriteView.setImage(
      with: model.sprite,
      noImagePlaceholder: DefinedImages.pokeball.image)
  }
}
