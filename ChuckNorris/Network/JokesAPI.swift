//
//  JokesAPI.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

import Foundation
import Combine

public class JokesAPI: JokesLoader {

    public enum Error: Swift.Error, Equatable {
        
        case invalidData
        case invalidURL
        case responseError(Swift.Error)
        
        public static func == (lhs: JokesAPI.Error, rhs: JokesAPI.Error) -> Bool {
            lhs.localizedDescription == rhs.localizedDescription
        }
    }
    
    private let urlString: String
    private let client: HTTPClient
    private var cancellableStore: Set<AnyCancellable>
    
    public init(client: HTTPClient, urlString: String = "http://anyURL.com") {
        self.client = client
        self.urlString = urlString
        cancellableStore = []
    }
    
    public func loadRandomJokes() -> Future<Jokes, Error> {
        Future<Jokes, JokesAPI.Error> { [unowned self] promise in
            
            guard let url = URL(string: urlString) else {
                promise(.failure(.invalidURL))
                return
            }
            
            client.getJokes(from: url)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        
                        case is DecodingError:
                            promise(.failure(.invalidData))
                            
                        default:
                            promise(.failure(.responseError(error)))
                        }
                    }
                },
                receiveValue: { jokes in
                    
                    promise(.success(jokes))
                })
                .store(in: &cancellableStore)
        }
    }
}
