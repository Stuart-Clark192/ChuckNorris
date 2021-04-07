//
//  JokeLoader.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

import Combine

public protocol JokesLoader {
    func loadRandomJokes() -> Future<Jokes, JokesAPI.Error>
}
