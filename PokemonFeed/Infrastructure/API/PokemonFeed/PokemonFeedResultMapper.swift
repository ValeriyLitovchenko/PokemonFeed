//
//  PokemonFeedResultMapper.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

/// Provide functionality for response + data validation while Pokemons array decoding from server response
enum PokemonFeedResultMapper {
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Pokemon] {
    try HTTPURLResponseValidator.validate(response)
    let page = try JSONDecoder().decode(PokemonFeedPageDTO.self, from: data)
    return page.results
  }
}

/// Pokemons page decodable data transfer object
private struct PokemonFeedPageDTO: Decodable {
  let results: [PokemonDTO]
}

/// Pokemon decodable data transfer object
private struct PokemonDTO: Pokemon, Decodable {
  
  // MARK: - Properties
  
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
    
    // Pokemon DTO in response from server contains only name and url
    // and `id` can be received only by separate url on components
    // and taking last which is pokemonId
    let url = try container.decode(String.self, forKey: .url)
    id = String(url.components(separatedBy: "/").dropLast().last ?? "")
    
    /*
     Since there's only one way provided by the api to get pokemon's sprite url
     is to get massive pokemon info and it's painfull for productivity
     and will cause huge amount of requests to be sent on server,
     decided to use api provided base url to generate pokemon's image url string with it's ID.
     */
    sprite = "\(AppConstants.pokemonSpriteURLString)/\(id).png"
  }
}
