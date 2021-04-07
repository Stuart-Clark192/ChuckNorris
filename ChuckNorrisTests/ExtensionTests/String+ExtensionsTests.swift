//
//  String+ExtensionsTests.swift
//  ChuckNorrisTests
//
//  Created by Stuart on 05/04/2021.
//

import XCTest
@testable import ChuckNorris

class String_ExtensionsTests: XCTestCase {
    
    func test_callingSanatisedQuotedString_removesQuotePlaceholders() {
        
        let sut = "And the &quot;boat&quot; sank"
        
        XCTAssertEqual(sut.sanatisedQuotedString, "And the 'boat' sank")
    }
    
    func test_callingSanatisedNonQuotedString_doesNotChangeString() {
        
        let sut = "And the boat sank"
        
        XCTAssertEqual(sut.sanatisedQuotedString, "And the boat sank")
    }
}
