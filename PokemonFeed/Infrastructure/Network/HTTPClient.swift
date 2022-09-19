//
//  HTTPClient.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

/// Base interface for network client
protocol HTTPClient {
  typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
  
  /// Performs cancelable network request with success/failure result on completion
  func get(
    from urlRequest: URLRequest,
    completion: @escaping ValueCallback<Result>
  ) -> HTTPClientTask
}

/// Base interface for cancelable network client task
protocol HTTPClientTask {
  func cancel()
}
