//
//  HTTPClient+Combine.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation
import Combine

extension HTTPClient {
  typealias Publisher = AnyPublisher<(Data, HTTPURLResponse), Error>
  
  /// Performs request asynchronously with propagating result through HTTPClient.Publisher
  func getPublisher(urlRequest: URLRequest) -> Publisher {
    var task: HTTPClientTask?
    
    return Deferred {
      Future { completion in
        task = self.get(from: urlRequest, completion: completion)
      }
    }
    .handleEvents(receiveCancel: { task?.cancel() })
    .eraseToAnyPublisher()
  }
}
