//
//  PokemonFeedControllerView.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import UIKit

final class PokemonFeedControllerView: BaseTableViewControllerView {
  
  // MARK: - Properties
  
  override var usedCells: [UITableViewCell.Type] {
    [
      PokemonFeedItemCell.self,
      PokemonFeedNoResultsCell.self
    ]
  }
  
  private(set) lazy var activityIndicator = addActivityIndicatorView()
}
