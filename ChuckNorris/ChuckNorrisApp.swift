//
//  ChuckNorrisApp.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

import SwiftUI

@main
struct ChuckNorrisApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = JokesUIComposer.makeJokesViewModel()
            JokesView(viewModel: viewModel)
        }
    }
}
