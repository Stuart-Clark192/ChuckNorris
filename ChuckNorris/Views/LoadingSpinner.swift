//
//  LoadingSpinner.swift
//  ChuckNorris
//
//  Created by Stuart on 06/04/2021.
//

import SwiftUI

struct LoadingSpinner: View {
    
    @State var angle: Double = 0.0
    @State var isAnimating = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack {
            Image("ChuckIcon")
                .resizable()
                .frame(width: 50.0, height: 50.0, alignment: .center)
                .padding(.horizontal)
                .rotationEffect(Angle(degrees: self.isAnimating ? 360.0 : 0.0))
                .animation(self.foreverAnimation)
                .onAppear {
                    self.isAnimating = true
                }
            
            Text("Chuck Loading")
        }
    }
}

struct LoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinner()
    }
}
