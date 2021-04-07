//
//  JokesViewModel.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

import Foundation
import Combine

enum ViewState {
    case loading
    case data
    case noData
    case error
}

class JokesViewModel: ObservableObject {
    
    @Published private(set) var jokes: [Joke] = []
    @Published private(set) var viewState: ViewState = .noData
    
    private let jokesLoader: JokesLoader
    
    public var cancellableStore: Set<AnyCancellable>
    
    public init(jokesLoader: JokesLoader) {
        
        self.jokesLoader = jokesLoader
        cancellableStore = []
    }
    
    public func loadJokes() {
        
        jokes = []
        viewState = .loading
        jokesLoader.loadRandomJokes()
            
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    self?.viewState = .error
                }
            } receiveValue: { [weak self] jokesResponse in
                self?.jokes = jokesResponse.value
                self?.viewState = jokesResponse.value.isEmpty ? .noData : .data
                
            }.store(in: &cancellableStore)
    }
}
