//
//  FlickrPhotosTests.swift
//  FlickrPhotosTests
//
//  Created by Srinivas Gadda on 11/05/24.
//

import XCTest
@testable import FlickrPhotos

final class FlickrPhotosTests: XCTestCase {

    var viewModelUnderTest: FlickrFeedViewModel!
    var mockClient: MockApiClient!
    
    override func setUpWithError() throws {
        mockClient = MockApiClient()
        viewModelUnderTest = FlickrFeedViewModel(apiClient: mockClient)
    }

    override func tearDownWithError() throws {
        mockClient = nil
        viewModelUnderTest = nil
    }

    func testSuccessFeed() {
        let feedItems = mockClient.fetchSuccessFeed()
        mockClient.result = .success(feedItems)
        let expectation = XCTestExpectation(description: "success feed test")
        Task {
            await viewModelUnderTest.fetchPhotos(searchTerm: "flowers")
            expectation.fulfill()
            XCTAssertTrue(viewModelUnderTest.feedItems?.count ?? 0 > 0)
        }
        wait(for: [expectation], timeout: 2.0)
    }

    func testFailedFeed() {
        mockClient.result = .failure(.invalidRequest)
        let expectation = XCTestExpectation(description: "fail feed test")
        Task {
            await viewModelUnderTest.fetchPhotos(searchTerm: "flowers")
            expectation.fulfill()
            XCTAssertFalse(viewModelUnderTest.feedItems?.count ?? 0 > 0)
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
