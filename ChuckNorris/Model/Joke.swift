//
//  Joke.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

struct Joke: Decodable {
    let id: Int
    let joke: String
    let categories: [String]
}
