//
//  BaseTableViewReusableViews.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

/// Base type for table cell model objects
class BaseTableCellModel: CellModel {
  
  // MARK: - Properties
  
  let cellHeight: CGFloat
  
  var type: UITableViewCell.Type {
    fatalError("Should be implemented by subclass")
  }
  
  // MARK: - Constructor
  
  init(height: CGFloat = UITableView.automaticDimension) {
    cellHeight = height
  }
  
  // MARK: - Destructor
  
  deinit {
    debugPrint("Did deinit \(String(describing: self.self))")
  }
}

/// Base type for table cells
class BaseTableCell: UITableViewCell {
  
  // MARK: - Destructor
  
  deinit {
    debugPrint("Did deinit \(String(describing: type(of: self)))")
  }
  
  // MARK: - Functions
  
  func configure(with _: BaseTableCellModel) {
    fatalError("Should be implemented by subclass")
  }
}
