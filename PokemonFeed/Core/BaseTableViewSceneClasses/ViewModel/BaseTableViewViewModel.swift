//
//  BaseTableViewViewModel.swift
//  PokemonFeed
//
//  Created by Valeriy L on 15.09.2022.
//

import Foundation

class BaseTableViewViewModel: BaseTableViewViewModelProtocol {
  
  // MARK: - Properties
  
  private(set) var content = TableViewViewModelContent()
  
  // MARK: - Functions
  
  func updateContent(with content: TableViewViewModelContent) {
    self.content = content
  }
}
