//
//  PokemonDetailsResultMapper.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Foundation

/// Provide functionality for response + data validation while and PokemonDetails decoding from server response
enum PokemonDetailsResultMapper {
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> PokemonDetails {
    try HTTPURLResponseValidator.validate(response)
    return try JSONDecoder().decode(PokemonDetailsDTO.self, from: data)
  }
}

/// Decodable pokemon details data transfer object
private struct PokemonDetailsDTO: PokemonDetails, Decodable {
  
  // MARK: - CodingKeys
  
  enum CodingKeys: String, CodingKey {
    case sprites
    case height
    case weight
    case abilities
  }
  
  enum SpritesKeys: String, CodingKey {
    case other
  }
  
  enum OtherSpritesKeys: String, CodingKey {
    case artwork = "official-artwork"
  }
  
  enum ArtworkKeys: String, CodingKey {
    case front = "front_default"
  }
  
  // MARK: - Properties
  
  let sprite: String?
  let height: Int
  let weight: Int
  let abilities: [String]
  
  // MARK: - Constructor
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    /*
     Response object has nested structure and to receive `front_default` artwork needs to pass
     Pokemon->sprites->official-artwork->front_default
    */
    let artworkContainer = try container.nestedContainer(keyedBy: SpritesKeys.self, forKey: .sprites)
      .nestedContainer(keyedBy: OtherSpritesKeys.self, forKey: .other)
      .nestedContainer(keyedBy: ArtworkKeys.self, forKey: .artwork)
    
    sprite = try? artworkContainer.decode(String.self, forKey: .front)
    
    height = try container.decode(Int.self, forKey: .height)
    weight = try container.decode(Int.self, forKey: .weight)
    
    let abilities = try container.decode([PokemonAbilityDTO].self, forKey: .abilities)
    self.abilities = abilities.map(\.name)
  }
}

/// Decodable pokemon ability data transfer object
private struct PokemonAbilityDTO: Decodable {
  
  // MARK: - CodingKeys
  
  enum CodingKeys: String, CodingKey {
    case ability
  }
  
  enum AbilityCodingKeys: String, CodingKey {
    case name
  }
  
  // MARK: - Properties
  
  let name: String
  
  // MARK: - Constructor
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let abilityContainer = try container.nestedContainer(keyedBy: AbilityCodingKeys.self, forKey: .ability)
    
    name = try abilityContainer.decode(String.self, forKey: .name)
  }
}
