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
      PokemonVarietyCell.self,
      PokemonDetailsImageCell.self,
      PokemonDetailsAttributeCell.self,
      PokemonDetailsAbilitiesCell.self,
      PokemonDetailsSectionTitleCell.self
    ]
  }
  
  private(set) lazy var activityIndicator = addActivityIndicatorView()
}
