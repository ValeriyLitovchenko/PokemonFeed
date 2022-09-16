//
//  BaseTableViewViewModelProtocol.swift
//  PokemonFeed
//
//  Created by Valeriy L on 16.09.2022.
//

import Foundation

protocol BaseTableViewViewModelProtocol: AnyObject {
  typealias TableViewViewModelContent = [TableSectionModel]
  
  var content: TableViewViewModelContent { get }
  func updateContent(with content: TableViewViewModelContent)
}
