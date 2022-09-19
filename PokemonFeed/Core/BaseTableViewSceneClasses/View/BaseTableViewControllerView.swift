//
//  BaseTableViewControllerView.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

/// Base class for TableViewController view
class BaseTableViewControllerView: BaseView {
  
  // MARK: - Outlets
  
  @IBOutlet private(set) weak var tableView: UITableView!
  
  // MARK: - Properties
  
  var usedCells: [UITableViewCell.Type] {
    fatalError("Should be implemented by subclass")
  }
}
