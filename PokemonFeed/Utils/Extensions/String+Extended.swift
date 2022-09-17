//
//  String+Extended.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

extension String {
  var nilIfEmpty: String? {
    isEmpty ? nil : self
  }
  
  var firstUppercased: String {
    prefix(1).uppercased() + dropFirst().lowercased()
  }
}
