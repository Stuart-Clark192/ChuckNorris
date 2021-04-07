//
//  ErrorViewModelTests.swift
//  ChuckNorrisTests
//
//  Created by Stuart on 07/04/2021.
//

import XCTest
@testable import ChuckNorris

class ErrorViewModelTests: XCTestCase {
    
    func test_ErrorView_initializesCorrectly() {
        
        var closureExecuted = false
        
        let sut = makeSUT() {
            closureExecuted = true
        }
        
        XCTAssertEqual("description", sut.errorDescription)
        XCTAssertEqual("fix", sut.errorSuggestedFix)
        sut.retry()
        
        XCTAssertTrue(closureExecuted)
    }

    // Helpers
    private func makeSUT(retry: @escaping () -> Void,
                         file: StaticString = #filePath,
                         line: UInt = #line) -> ErrorViewModel {
       
        let sut = ErrorViewModel(errorDescription: "description", errorSuggestedFix: "fix", retry: retry)
        return sut
    }
}
