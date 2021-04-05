//
//  HTTPClient.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

import Foundation
import Combine

public protocol HTTPClient {
    
    func getJokes(from url: URL) -> AnyPublisher<Jokes, Error>
}
