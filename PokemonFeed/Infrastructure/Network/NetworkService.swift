//
//  NetworkService.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation
import Combine
 
/// Base interface for client-server interactions service
protocol NetworkService {
  /// Factory method for instantiating urlrequest
  typealias URLRequestFactoryMethod = ((_ baseURL: URL) -> URLRequest)
  
  /// Performs request provided by URLRequestFactoryMethod asynchronously with propagating result through AnyPublisher
  func request(urlRequest: URLRequestFactoryMethod) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}
