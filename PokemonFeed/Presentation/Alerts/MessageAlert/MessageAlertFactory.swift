//
//  MessageAlertFactory.swift
//  PokemonFeed
//
//  Created by Valeriy L on 19.09.2022.
//

import UIKit

/// Context based named UIAlertController representation
typealias MessageAlertController = UIAlertController

/// Factory that instantiates MessageAlert
protocol MessageAlertFactory {
  func makeMessageAlert(with model: MessageAlertModel) -> MessageAlertController
}

extension MessageAlertFactory {
  func makeMessageAlert(with model: MessageAlertModel) -> MessageAlertController {
    let alert = UIAlertController(
      title: model.title,
      message: model.message,
      preferredStyle: .alert)
    
    model.actions.forEach { action in
      alert.addAction(
        UIAlertAction(
          title: action.title,
          style: action.type == .canceling ? .cancel : .default,
          handler: { _ in
            action.handler?()
          })
      )
    }
    return alert
  }
}
