//
//  String+Extensions.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

import Foundation

extension String {
    
    var sanatisedQuotedString: String {
        
        return self.replacingOccurrences(of: "&quot;", with: "'", options: .caseInsensitive)
    }
}
