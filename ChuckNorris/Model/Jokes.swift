//
//  Jokes.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

struct Jokes: Decodable {
    let type: String
    let value: [Joke]
}

