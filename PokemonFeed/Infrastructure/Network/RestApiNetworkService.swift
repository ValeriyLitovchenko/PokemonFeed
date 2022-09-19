//
//  RestApiNetworkService.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation
import Combine

/// Rest api service for client-server interactions
final class RestApiNetworkService: NetworkService {
  
  // MARK: - Properties
  
  private let baseURL: URL
  private let httpClient: HTTPClient
  
  // MARK: - Constructor
  
  init(
    baseURL: URL,
    httpClient: HTTPClient
  ) {
    self.baseURL = baseURL
    self.httpClient = httpClient
  }
  
  // MARK: - Functions
  
  func request(urlRequest: URLRequestFactoryMethod) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
    httpClient.getPublisher(urlRequest: urlRequest(baseURL))
  }
}
