//
//  HTTPClient.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

protocol HTTPClient {
  typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
  
  func get(
    from urlRequest: URLRequest,
    completion: @escaping ValueCallback<Result>
  ) -> HTTPClientTask
}

protocol HTTPClientTask {
  func cancel()
}
