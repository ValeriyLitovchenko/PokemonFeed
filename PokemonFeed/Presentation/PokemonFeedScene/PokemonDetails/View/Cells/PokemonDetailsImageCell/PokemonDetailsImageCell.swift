//
//  PokemonDetailsImageCell.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import UIKit

final class PokemonDetailsImageCellModel: BaseTableCellModel {
  
  // MARK: - Properties
  
  override var type: UITableViewCell.Type {
    PokemonDetailsImageCell.self
  }
  
  let sprite: String?
  
  // MARK: - Constructor
  
  init(sprite: String?) {
    self.sprite = sprite
    super.init(height: 230.0)
  }
}

final class PokemonDetailsImageCell: BaseTableCell {
  
  // MARK: - Outlets
  
  @IBOutlet private weak var spriteImageViww: UIImageView!
  
  // MARK: - Functions
  
  // With empty body disables cell highlighting while tapping on it
  override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
  
  override func configure(with model: BaseTableCellModel) {
    guard let model = model as? PokemonDetailsImageCellModel else {
      fatalError("Wrong item provided to cell")
    }
    
    spriteImageViww.setImage(
      with: model.sprite,
      noImagePlaceholder: DefinedImages.pokeball.image)
  }
}
