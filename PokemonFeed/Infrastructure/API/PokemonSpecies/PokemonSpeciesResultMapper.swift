//
//  PokemonSpeciesResultMapper.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Foundation

enum PokemonSpeciesResultMapper {
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> PokemonSpecies? {
    try HTTPURLResponseValidator.validate(response)
    return try JSONDecoder().decode(PokemonSpeciesDTO.self, from: data)
  }
}

private struct PokemonSpeciesDTO: PokemonSpecies, Decodable {
  
  // MARK: - CodingKeys
  
  enum CodingKeys: String, CodingKey {
    case generation
    case growthRate = "growth_rate"
    case habitat
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
  
  // MARK: - Constructor
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let generationContainer = try container.nestedContainer(
      keyedBy: GenerationCodingKeys.self,
      forKey: CodingKeys.generation)
    generation = try generationContainer.decode(String.self, forKey: .name)
    
    let growthRateContainer = try container.nestedContainer(
      keyedBy: GrowthRateCodingKeys.self,
      forKey: CodingKeys.generation)
    growthRate = try growthRateContainer.decode(String.self, forKey: .name)
    
    let habitatContainer = try container.nestedContainer(
      keyedBy: HabitatCodingKeys.self,
      forKey: CodingKeys.generation)
    habitat = try habitatContainer.decode(String.self, forKey: .name)
  }
}
