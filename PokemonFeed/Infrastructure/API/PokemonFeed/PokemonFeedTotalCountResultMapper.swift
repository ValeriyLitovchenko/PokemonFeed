//
//  PokemonFeedTotalCountResultMapper.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

enum PokemonFeedTotalCountResultMapper {
  private enum Error: Swift.Error {
    case unsupportedStatusCode(Int)
  }
  
  // MARK: - Functions
  
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> Int {
    try HTTPURLResponseValidator.validate(response)
    let result = try JSONDecoder().decode(PokemonFeedTotalCountDTO.self, from: data)
    return result.count
  }
}

private struct PokemonFeedTotalCountDTO: Decodable {
  let count: Int
}
