//
//  ErrorViewModel.swift
//  ChuckNorris
//
//  Created by Stuart on 07/04/2021.
//

struct ErrorViewModel {
    
    let errorDescription: String
    let errorSuggestedFix: String
    let imageName: String
    let retry: () -> Void
    
    init(errorDescription: String = "And broke the internet",
         errorSuggestedFix: String = "Please check your connection!",
         retry: @escaping () -> Void) {
        self.errorDescription = errorDescription
        self.errorSuggestedFix = errorSuggestedFix
        imageName = "ChuckNorrisError"
        self.retry = retry
    }
}
