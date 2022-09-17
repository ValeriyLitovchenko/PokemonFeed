//
//  NetworkService.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation
import Combine

protocol NetworkService {
  typealias URLRequestFactoryMethod = ((_ baseURL: URL) -> URLRequest)
  
  func request(urlRequest: URLRequestFactoryMethod) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}
