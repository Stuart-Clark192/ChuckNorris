//
//  String+ExtensionsTests.swift
//  ChuckNorrisTests
//
//  Created by Stuart on 05/04/2021.
//

import XCTest
@testable import ChuckNorris

class String_ExtensionsTests: XCTestCase {

    func test_stringWithValidURL_ReturnsTrueForIsValidURL() {
        
        let sut = "http://www.anyURL.com"
        
        XCTAssertTrue(sut.isValidURL)
    }
    
    func test_stringWithInvalidURL_ReturnsFalseForIsValidURL() {
        
        let sut = "just a regular string"
        
        XCTAssertFalse(sut.isValidURL)
    }
}
