//
//  JokeViewModel.swift
//  ChuckNorris
//
//  Created by Stuart on 07/04/2021.
//

struct JokeViewModel {
    
    let jokeText: String
    let imageName: String
    
    init(joke: Joke) {
        jokeText = joke.joke.sanatisedQuotedString
        imageName = "ChuckIcon"
    }
}
