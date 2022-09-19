//
//  PokemonSpeciesApiEndpoint.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Foundation

/// Server Api endpoint for requesting pokemon species data
enum PokemonSpeciesApiEndpoint {
  case getPokemonSpecies(id: String)
  
  /// Instantiates URLRequest with baseURL for one of the PokemonSpeciesApiEndpoint cases
  func urlRequest(baseURL: URL) -> URLRequest {
    switch self {
    case let .getPokemonSpecies(id):
      var components = URLComponents()
      components.scheme = baseURL.scheme
      components.host = baseURL.host
      components.path = baseURL.path + "/pokemon-species/\(id)"
      
      // swiftlint:disable force_unwrapping
      return URLRequest(url: components.url!)
    }
  }
}
