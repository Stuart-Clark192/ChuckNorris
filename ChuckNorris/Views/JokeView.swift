//
//  Joke.swift
//  ChuckNorris
//
//  Created by Stuart on 06/04/2021.
//

import SwiftUI

struct JokeView: View {
    
    var viewModel: JokeViewModel
    
    var body: some View {
        
        HStack {
            Image(viewModel.imageName)
                .resizable()
                .frame(width: 50.0, height: 50.0, alignment: .center)
                .padding(.horizontal)
            
            Text(viewModel.jokeText)
            
        }.padding()
    }
}

struct Joke_Previews: PreviewProvider {
    static var previews: some View {
        
        let joke = Joke(id: 1,
                        joke: "A test joke with a really really long string that will wrap and wrap and wrap just to make sure ",
                        categories: [])
        let viewModel = JokeViewModel(joke: joke)
        JokeView(viewModel: viewModel)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 Pro")
    }
}
