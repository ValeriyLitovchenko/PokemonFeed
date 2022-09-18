//
//  PokemonDetailsControllerView.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import UIKit

final class PokemonDetailsControllerView: BaseTableViewControllerView {
  
  // MARK: - Properties
  
  override var usedCells: [UITableViewCell.Type] {
    [
      PokemonDetailsImageCell.self,
      PokemonDetailsAttributeCell.self,
      PokemonDetailsSectionTitleCell.self
    ]
  }
}
