//
//  Joke.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

public struct Joke: Decodable {
    
    public let id: Int
    public let joke: String
    public let categories: [String]
    
}
