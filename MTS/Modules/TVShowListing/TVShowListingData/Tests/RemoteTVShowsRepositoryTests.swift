//
//  SomeTest.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import XCTest
import TVShowListingFeatureDomain
import NetworkCoreInterface
@testable import TVShowListingFeatureData

// Test Utils
import TVShowListingFeatureTesting
import NetworkCoreTesting

final class RemoteTVShowsRepositoryTests: XCTestCase {
    private var sut: RemoteTVShowsRepository!
    private var networkClientSpy: NetworkClientSpy!
    
    override func setUp() {
        super.setUp()
        networkClientSpy = NetworkClientSpy(expectedResponse: .ok())
        sut = RemoteTVShowsRepository(networkClient: networkClientSpy)
    }
    
    override func tearDown() {
        networkClientSpy = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - getTVShows
    
    func test_getTVShows_onExecute_withValidResponse_shouldReturnDecodedTVShows() async throws {
        // Given
        let mockTVShows: [TVShow] = [
            TVShow(id: 1, name: "Show 1", type: "", language: "", genres: [], status: "", averageRuntime: nil, premiered: nil, ended: nil, officialSite: nil, schedule: .init(time: "", days: []), rating: .init(average: nil), network: nil, webChannel: nil, image: nil, summary: nil)
        ]
        networkClientSpy.responseData = try JSONEncoder().encode(mockTVShows)
        
        // When
        let result = try await sut.getTVShows()
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 1)
        XCTAssertEqual(networkClientSpy.callCount, 1)
    }
    
    func test_getTVShows_onExecute_withInvalidResponse_shouldThrowDecodingError() async {
        // Given
        networkClientSpy.responseData = Data("invalid json".utf8)
        
        // When / Then
        await AsyncAssertions.throwsError(try await self.sut.getTVShows()) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func test_getTVShows_onExecute_withClientError_shouldThrowSameError() async {
        // Given
        let expectedError = URLError(.badServerResponse)
        networkClientSpy.errorToThrow = expectedError
        
        // When / Then
        await AsyncAssertions.throwsError(try await self.sut.getTVShows()) { error in
            XCTAssertEqual(error as? URLError, expectedError)
        }
    }
    
    // MARK: - searchTVShows
    
    func test_searchTVShows_onExecute_withValidResponse_shouldReturnDecodedResults() async throws {
        // Given
        let mockResults: [TVShowSearchResult] = [
            TVShowSearchResult(score: 0.9, show: .init(id: 2, name: "Search Match", type: "", language: "", genres: [], status: "", averageRuntime: nil, premiered: nil, ended: nil, officialSite: nil, schedule: .init(time: "", days: []), rating: .init(average: nil), network: nil, webChannel: nil, image: nil, summary: nil))
        ]
        networkClientSpy.responseData = try JSONEncoder().encode(mockResults)
        
        // When
        let result = try await sut.searchTVShows(query: "Search")
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.show.id, 2)
        XCTAssertEqual(networkClientSpy.callCount, 1)
    }
    
    func test_searchTVShows_onExecute_withInvalidResponse_shouldThrowDecodingError() async {
        // Given
        networkClientSpy.responseData = Data("bad json".utf8)
        
        // When / Then
        await AsyncAssertions.throwsError(try await self.sut.searchTVShows(query: "Search")) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func test_searchTVShows_onExecute_withClientError_shouldThrowSameError() async {
        // Given
        let expectedError = URLError(.cannotFindHost)
        networkClientSpy.errorToThrow = expectedError
        
        // When / Then
        await AsyncAssertions.throwsError(try await self.sut.searchTVShows(query: "Search")) { error in
            XCTAssertEqual(error as? URLError, expectedError)
        }
    }
}

