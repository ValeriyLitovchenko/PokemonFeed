//
//  String+Extended.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

extension String {
  /// Returns nil value if string is empty
  var nilIfEmpty: String? {
    isEmpty ? nil : self
  }
  
  /// Uppercase first character of a string
  var firstUppercased: String {
    prefix(1).uppercased() + dropFirst().lowercased()
  }
}
