//
//  GetPokemonFeedApiEndpoint.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

struct GetPokemonFeedApiEndpoint {
  
  // MARK: - Properties
  
  let limit: Int
  let offset: Int
  
  // MARK: - Functions
  
  func urlRequest(baseURL: URL) -> URLRequest {
    var components = URLComponents()
    components.scheme = baseURL.scheme
    components.host = baseURL.host
    components.path = baseURL.path + "/pokemon"
    components.queryItems = [
      .init(name: "limit", value: "\(limit)"),
      .init(name: "offset", value: "\(offset)")
    ]
    
    // swiftlint:disable force_unwrapping
    return URLRequest(url: components.url!)
  }
}
