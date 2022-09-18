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
  
  static func validate(
    _ response: HTTPURLResponse,
    ignore ignoringCodes: [Int]? = nil
  ) throws {
    guard response.isSuccessful else {
      if let ignoringCodes = ignoringCodes,
         ignoringCodes.contains(response.statusCode) {
        return
      }
      throw HTTPURLResponseValidator.Error.unsupportedStatusCode(response.statusCode)
    }
  }
}
