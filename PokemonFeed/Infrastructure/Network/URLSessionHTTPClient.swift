//
//  URLSessionHTTPClient.swift
//  PokemonFeed
//
//  Created by Valeriy L on 17.09.2022.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
  private struct UnexpectedValueRepresentation: Error {}
  
  private struct URLSessionTaskWrapper: HTTPClientTask {
    let wrappedTask: URLSessionTask
    
    func cancel() {
      wrappedTask.cancel()
    }
  }
  
  // MARK: - Properties
  
  private let session: URLSession
  
  // MARK: - Constructor
  
  init(session: URLSession) {
    self.session = session
  }
  
  // MARK: - Functions
  
  func get(
    from urlRequest: URLRequest,
    completion: @escaping ValueCallback<HTTPClient.Result>
  ) -> HTTPClientTask {
    let task = session.dataTask(
      with: urlRequest,
      completionHandler: { data, repsonse, error in
        completion(HTTPClient.Result {
          if let error = error {
            throw error
          } else if let data = data,
                    let response = repsonse as? HTTPURLResponse {
            return (data, response)
          } else {
            throw UnexpectedValueRepresentation()
          }
        })
      })
    
    task.resume()
    
    return URLSessionTaskWrapper(wrappedTask: task)
  }
  
}
