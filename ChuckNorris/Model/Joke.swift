//
//  Joke.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

public struct Joke: Decodable {
    
    let jokeId: Int
    let joke: String
    let categories: [String]
    
    enum CodingKeys: String, CodingKey {
        case jokeId = "id"
        case joke
        case categories
    }
}
