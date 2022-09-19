//
//  PokemonDetailsNavigationActions.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Foundation

struct PokemonDetailsNavigationActions {
  let openVarietyDetails: ValueCallback<PokemonDetailsInputModel>
  let showMessage: ValueCallback<MessageAlertModel>
  let close: VoidCallback
}
