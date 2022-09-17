//
//  HTTPURLResponseValidator.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

enum HTTPURLResponseValidator {
  private enum Error: Swift.Error {
    case unsupportedStatusCode(Int)
  }
  
  static func validate(_ response: HTTPURLResponse) throws {
    guard response.isSuccessful else {
      throw HTTPURLResponseValidator.Error.unsupportedStatusCode(response.statusCode)
    }
  }
}
