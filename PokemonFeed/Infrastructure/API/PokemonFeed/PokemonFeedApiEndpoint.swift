//
//  PokemonFeedApiEndpoint.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

enum PokemonFeedApiEndpoint {
  case getPokemonFeed(limit: Int)
  case getTotalCount
  
  func urlRequest(baseURL: URL) -> URLRequest {
    var components = URLComponents()
    components.scheme = baseURL.scheme
    components.host = baseURL.host
    components.path = baseURL.path + "/pokemon"
    
    switch self {
    case .getPokemonFeed(let limit):
      components.queryItems = [
        .init(name: "limit", value: "\(limit)"),
        .init(name: "offset", value: "\(Int.zero)")
      ]
      
    case .getTotalCount:
      components.queryItems = [
        .init(name: "limit", value: "\(1)"),
        .init(name: "offset", value: "\(Int.zero)")
      ]
    }
    
    // swiftlint:disable force_unwrapping
    return URLRequest(url: components.url!)
  }
}
