//
//  ErrorView.swift
//  ChuckNorris
//
//  Created by Stuart on 06/04/2021.
//

import SwiftUI

struct ErrorView: View {
    
    var viewModel: ErrorViewModel
    
    var body: some View {
        VStack {
            VStack {
            Image(viewModel.imageName)
                .resizable()
                .frame(width: 200.0, height: 200.0, alignment: .center)
                .padding(.horizontal)
            Text(viewModel.errorDescription)
            Text(viewModel.errorSuggestedFix)
            }.padding()
            
            HStack {
                Image(systemName: "arrow.counterclockwise.circle")
                Text("Tap to retry")
            }
            
        }.padding()
        .onTapGesture {
            viewModel.retry()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ErrorViewModel(retry: {})
        ErrorView(viewModel: viewModel)
    }
}
