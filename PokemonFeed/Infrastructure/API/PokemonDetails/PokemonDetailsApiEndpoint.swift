//
//  PokemonDetailsApiEndpoint.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Foundation

/// Server Api endpoint for requesting pokemon detailed data
enum PokemonDetailsApiEndpoint {
  case getPokemonDetails(id: String)
  
  /// Instantiates URLRequest with baseURL for one of the PokemonDetailsApiEndpoint cases
  func urlRequest(baseURL: URL) -> URLRequest {
    switch self {
    case let .getPokemonDetails(id):
      var components = URLComponents()
      components.scheme = baseURL.scheme
      components.host = baseURL.host
      components.path = baseURL.path + "/pokemon/\(id)"
      
      // swiftlint:disable force_unwrapping
      return URLRequest(url: components.url!)
    }
  }
}
