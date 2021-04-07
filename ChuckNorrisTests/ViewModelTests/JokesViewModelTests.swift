//
//  JokesViewModelTests.swift
//  ChuckNorrisTests
//
//  Created by Stuart on 07/04/2021.
//

import XCTest
import Combine
@testable import ChuckNorris

class JokesViewModelTests: XCTestCase {
    
    private var cancellableStore: Set<AnyCancellable> = []
    
    func test_loadJokes_assignsJokesToViewModel() {
        let (sut, client) = makeSUT()
        
        let jokes = Jokes(type: "success", value: [Joke(id: 1, joke: "A test joke", categories: [])])
        client.jokesToReturn = jokes
        
        let exp = expectation(description: "Jokes loaded")
        var stateChanges = [ViewState]()
    
        let stateSub = sut.$viewState.eraseToAnyPublisher()
        stateSub
            .sink { change in
                stateChanges.append(change)
                if(stateChanges.count == 3) {
                    exp.fulfill()
                }
            }
            .store(in: &cancellableStore)
        
        sut.loadJokes()
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertTrue(sut.jokes.count == 1)
        XCTAssertTrue(stateChanges.count == 3)
        XCTAssertEqual(stateChanges, [.noData, .loading, .data])
    }
    
    func test_loadJokes_assignsEmptyArrayToViewModel_WhenNoJokesReturned() {
        let (sut, client) = makeSUT()
        
        let jokes = Jokes(type: "success", value: [])
        client.jokesToReturn = jokes
        
        let exp = expectation(description: "Jokes loaded")
        var stateChanges = [ViewState]()
    
        let stateSub = sut.$viewState.eraseToAnyPublisher()
        stateSub
            .sink { change in
                stateChanges.append(change)
                if(stateChanges.count == 3) {
                    exp.fulfill()
                }
            }
            .store(in: &cancellableStore)
        
        sut.loadJokes()
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertTrue(sut.jokes.count == 0)
        XCTAssertTrue(stateChanges.count == 3)
        XCTAssertEqual(stateChanges, [.noData, .loading, .noData])
    }
    
    func test_loadJokes_assignsEmptyArrayToViewModel_WhenNetworkCallFails() {
        let (sut, client) = makeSUT()
        
        client.errorToReturn = NSError(domain: "Some Error", code: 1)
        
        let exp = expectation(description: "Network Failed")
        var stateChanges = [ViewState]()
    
        let stateSub = sut.$viewState.eraseToAnyPublisher()
        stateSub
            .sink { change in
                stateChanges.append(change)
                if(stateChanges.count == 3) {
                    exp.fulfill()
                }
            }
            .store(in: &cancellableStore)
        
        sut.loadJokes()
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertTrue(sut.jokes.count == 0)
        XCTAssertTrue(stateChanges.count == 3)
        XCTAssertEqual(stateChanges, [.noData, .loading, .error])
    }
    

    // Helpers
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: JokesViewModel, httpClientSpy: HTTPClientSpy) {
        let httpClientSpy = HTTPClientSpy()
        let jokesAPI = JokesAPI(client: httpClientSpy)
        let sut = JokesViewModel(jokesLoader: jokesAPI)
        
        trackForMemoryLeaks(httpClientSpy, file: file, line: line)
        trackForMemoryLeaks(jokesAPI, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)

        return (sut, httpClientSpy)
    }
}
