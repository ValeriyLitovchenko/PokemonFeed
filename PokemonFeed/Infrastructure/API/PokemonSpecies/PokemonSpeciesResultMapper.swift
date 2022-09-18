//
//  PokemonSpeciesResultMapper.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Foundation

enum PokemonSpeciesResultMapper {
  private enum StatusCodes {
    static let notFound = 404
  }
  
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> PokemonSpecies? {
    /*
     sometimes pokemon species can be absent.
     that's why need to ignore 404 status code
     */
    try HTTPURLResponseValidator.validate(response, ignore: [StatusCodes.notFound])
    return try? JSONDecoder().decode(PokemonSpeciesDTO.self, from: data)
  }
}

private struct PokemonSpeciesDTO: PokemonSpecies, Decodable {
  
  // MARK: - CodingKeys
  
  enum CodingKeys: String, CodingKey {
    case generation
    case growthRate = "growth_rate"
    case habitat
    case varieties
  }
  
  enum GenerationCodingKeys: String, CodingKey {
    case name
  }
  
  enum GrowthRateCodingKeys: String, CodingKey {
    case name
  }
  
  enum HabitatCodingKeys: String, CodingKey {
    case name
  }
  
  // MARK: - Properties
  
  let generation: String
  let growthRate: String
  let habitat: String
  let varieties: [PokemonVariety]
  
  // MARK: - Constructor
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let generationContainer = try container.nestedContainer(
      keyedBy: GenerationCodingKeys.self,
      forKey: CodingKeys.generation)
    generation = try generationContainer.decode(String.self, forKey: .name)
    
    let growthRateContainer = try container.nestedContainer(
      keyedBy: GrowthRateCodingKeys.self,
      forKey: CodingKeys.growthRate)
    growthRate = try growthRateContainer.decode(String.self, forKey: .name)
    
    let habitatContainer = try container.nestedContainer(
      keyedBy: HabitatCodingKeys.self,
      forKey: CodingKeys.habitat)
    habitat = try habitatContainer.decode(String.self, forKey: .name)
    
    varieties = try container.decode([PokemonVarietyDTO].self, forKey: .varieties)
  }
}

private struct PokemonVarietyDTO: Decodable, PokemonVariety {
  
  enum CodingKeys: String, CodingKey {
    case isDefault = "is_default"
    case pokemon
  }
  
  enum PokemonCodingKeys: String, CodingKey {
    case name
    case url
  }
  
  // MARK: - Properties
  
  let id: String
  let name: String
  let sprite: String
  
  // MARK: - Constructor
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let pokemonContainer = try container.nestedContainer(keyedBy: PokemonCodingKeys.self, forKey: .pokemon)
    
    name = try pokemonContainer.decode(String.self, forKey: .name)
    
    id = (try pokemonContainer.decode(String.self, forKey: .url))
      .dropLast()
      .components(separatedBy: "/")
      .last ?? ""
    /*
     Each `official-artwork` url requires a lot of additional actions.
     Decided to use api provided url to generate `official-artwork` url for unique variety id.
     */
    sprite = "\(AppConstants.pokemonSpriteURLString)/\(id).png"
  }
}
