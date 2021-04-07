//
//  HTTPClientSpy.swift
//  ChuckNorrisTests
//
//  Created by Stuart on 05/04/2021.
//

import Foundation
import Combine
@testable import ChuckNorris

class HTTPClientSpy: HTTPClient {
    
    var errorToReturn: Error?
    var jokesToReturn: Jokes?
    
    private(set) var requestedURLs = [URL?]()
    
    func getJokes(from url: URL) -> AnyPublisher<Jokes, Error> {
        requestedURLs.append(url)
        
        return Future<Jokes, Error> { promise in
            if let error = self.errorToReturn {
                promise(.failure(error))
            } else {
                if let jokes = self.jokesToReturn {
                    promise(.success(jokes))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
