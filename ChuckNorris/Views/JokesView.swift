//
//  ContentView.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

import SwiftUI

struct JokesView: View {
    
    @StateObject private var viewModel: JokesViewModel
    
    init(viewModel: JokesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        VStack {
            Text("Chuck Jokes")
                .font(.largeTitle)
            Spacer()
            body(for: viewModel.viewState)
            Spacer()
            
        }.onAppear {
            viewModel.loadJokes()
        }
    }
    
    @ViewBuilder
    private func body(for state: ViewState) -> some View {
        Group {
            
            switch viewModel.viewState {
            case .loading:
                LoadingSpinner()
            case .data:
                VStack {
                    List {
                        ForEach(viewModel.jokes) { joke in
                            JokeView(viewModel: JokeViewModel(joke: joke))
                        }
                    }
                    .listStyle(PlainListStyle())
                    HStack {
                        Image(systemName: "arrow.counterclockwise.circle")
                        Text("Tap to refresh")
                    }
                    .padding(.top)
                }.onTapGesture {
                    viewModel.loadJokes()
                }
            case .noData:
                Text("No Jokes")
            case .error:
                ErrorView(viewModel: ErrorViewModel(retry: {
                    viewModel.loadJokes()
                }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = JokesUIComposer.makeJokesViewModel()
        JokesView(viewModel: viewModel)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 12 Pro")
    }
}
