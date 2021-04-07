//
//  JokesAPITests.swift
//  ChuckNorrisTests
//
//  Created by Stuart on 05/04/2021.
//

import Combine
import XCTest
@testable import ChuckNorris

class JokesAPITests: XCTestCase {
    
    private var cancellableStore: Set<AnyCancellable> = []
    
    func test_init() {
        
        let (sut, client) = makeSUT()
        
        XCTAssertNotNil(sut as JokesLoader)
        XCTAssertNotNil(client as HTTPClient)
    }
    
    func test_callingLoadTwice_CallsURLTwice() {
        
        let (sut, client) = makeSUT()
        let _ = sut.loadRandomJokes()
        let _ = sut.loadRandomJokes()
        
        XCTAssertEqual(client.requestedURLs.count, 2, "Expected URL Count to be 2, got \(client.requestedURLs.count) instead")
    }
    
    func test_loadJokes_returnsExpectedError() throws {
        
        let (sut, client) = makeSUT()
        let expectedError = NSError(domain: "anyError", code: 1)
        client.errorToReturn = expectedError
        
        let _ = sut.loadRandomJokes()
            .sink { result in
                
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    XCTAssertEqual(error, .responseError(NSError(domain: "anyError", code: 1)))
                }
            } receiveValue: { _ in
                XCTFail("Request should have failed")
            }.store(in: &cancellableStore)
        
        XCTAssertEqual(client.requestedURLs.count, 1)
    }
    
    func test_loadJokes_returnsExpectedData() throws {
        
        let (sut, client) = makeSUT()
        let jokes = Jokes(type: "success", value: [Joke(id: 1, joke: "A test joke", categories: [])])
        client.jokesToReturn = jokes
        
        let _ = sut.loadRandomJokes()
            .sink { result in
                
                switch result {
                case .finished:
                    break
                case .failure(_):
                    XCTFail("Request should have succeeded")
                }
            } receiveValue: { jokesResponse in
                XCTAssertEqual(jokesResponse.type, "success")
                XCTAssertEqual(jokes.value.count, 1)
                XCTAssertEqual(jokes.value[0].joke, "A test joke")
            }.store(in: &cancellableStore)
        
        XCTAssertEqual(client.requestedURLs.count, 1)
    }
    
    
    // Helpers
    private func makeSUT(urlString: String = "http://anyURL.com", file: StaticString = #filePath, line: UInt = #line) -> (sut: JokesAPI, client: HTTPClientSpy) {
        
        let httpClient = HTTPClientSpy()
        let sut = JokesAPI(client: httpClient, urlString: urlString)
        
        trackForMemoryLeaks(httpClient, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, httpClient)
    }
    
}
