//
//  MessageAlertModel.swift
//  PokemonFeed
//
//  Created by Valeriy L on 19.09.2022.
//

import Foundation

struct MessageAlertModel {
  let title: String?
  let message: String?
  let actions: [MessageAlertAction]
}

struct MessageAlertAction {
  
  // MARK: - Property
  
  let type: AlertActionType
  let title: String
  let handler: VoidCallback?
  
  // MARK: - Constructor
  
  init(
    type: AlertActionType,
    title: String,
    handler: VoidCallback? = nil
  ) {
    self.type = type
    self.title = title
    self.handler = handler
  }
}

enum AlertActionType {
  case confirming
  case canceling
}
