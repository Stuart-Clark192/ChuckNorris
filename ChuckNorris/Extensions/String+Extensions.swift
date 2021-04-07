//
//  String+Extensions.swift
//  ChuckNorris
//
//  Created by Stuart on 05/04/2021.
//

import Foundation

extension String {
    
    var isValidURL: Bool {
        
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        if let match = detector?.firstMatch(in: self,
                                            options: [],
                                            range: NSRange(location: 0, length: utf16.count)) {
            return match.range.length == utf16.count
        } else {
            return false
        }
    }
    
    var sanatisedQuotedString: String {
        
        return self.replacingOccurrences(of: "&quot;", with: "'", options: .caseInsensitive)
    }
}
