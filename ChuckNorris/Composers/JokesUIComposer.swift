//
//  JokesUIComposer.swift
//  ChuckNorris
//
//  Created by Stuart on 06/04/2021.
//

enum JokesUIComposer {
    
    static func makeJokesViewModel() -> JokesViewModel {
        
        let httpClient = URLSessionHTTPClient()
        let jokesLoader = JokesAPI(client: httpClient, urlString: "http://api.icndb.com/jokes/random/30?exclude=[explicit]")
        let viewModel = JokesViewModel(jokesLoader: jokesLoader)
        
        return viewModel
    }
}
