//
//  URLSessionHTTPClient.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

import Foundation
import Combine

public class URLSessionHTTPClient: HTTPClient {
    
    private let sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")
    
    private var session: URLSession {
        
        let configuration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration)
    }
    
    public init() {}
    
    public func getJokes(from url: URL) -> AnyPublisher<Jokes, Error> {
        session.dataTaskPublisher(for: url)
            .retry(1)
            .receive(on: sessionProcessingQueue)
            .tryMap() { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      200...299 ~= response.statusCode else {
                    throw NSError(domain: "response error",
                                  code: (element.response as? HTTPURLResponse)?.statusCode ?? 400)
                }
                return element.data
            }
            .decode(type: Jokes.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
