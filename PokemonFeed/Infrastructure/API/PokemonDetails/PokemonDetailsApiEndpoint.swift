//
//  PokemonDetailsApiEndpoint.swift
//  PokemonFeed
//
//  Created by Valeriy L on 18.09.2022.
//

import Foundation

enum PokemonDetailsApiEndpoint {
  case getPokemonDetails(id: String)
  
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
