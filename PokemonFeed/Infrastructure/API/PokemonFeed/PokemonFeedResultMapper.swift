//
//  PokemonFeedResultMapper.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

enum PokemonFeedResultMapper {
  private enum Error: Swift.Error {
    case unsupportedStatusCode(Int)
  }
  
  // MARK: - Functions
  
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> PokemonFeedPage {
    try validate(response)
    return try JSONDecoder().decode(PokemonFeedPageDTO.self, from: data)
  }
  
  // MARK: - Private functions
  
  private static func validate(_ response: HTTPURLResponse) throws {
    guard response.isSuccessful else {
      throw PokemonFeedResultMapper.Error.unsupportedStatusCode(response.statusCode)
    }
  }
}

private struct PokemonFeedPageDTO: PokemonFeedPage, Decodable {
  
  // MARK: - Properties
  
  let totalCount: Int
  var pokemons: [Pokemon] {
    results
  }
  private let results: [PokemonDTO]
  
  enum CodingKeys: String, CodingKey {
    case count
    case results
  }
  
  // MARK: - Constructor
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    totalCount = try container.decode(Int.self, forKey: .count)
    results = try container.decode([PokemonDTO].self, forKey: .results)
  }
}

private struct PokemonDTO: Pokemon, Decodable {
  
  // MARK: - Property
  
  let id: String
  let name: String
  let sprite: String
  
  enum CodingKeys: String, CodingKey {
    case name
    case url
  }
  
  // MARK: - Constructor
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    
    let url = try container.decode(String.self, forKey: .url)
    id = String(url.components(separatedBy: "/").dropLast().last ?? "")
    
    /*
     Since there's only one way provided by the api to get pokemon's sprite url
     is to get massive pokemon info and it's painfull for productivity
     and will cause huge amount of requests to be sent on server,
     decided to use api provided base url to generate pokemon's image url string with it's ID.
     */
    sprite = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
  }
}
