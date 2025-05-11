//
//  SearchTVShowsUseCaseTests.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import XCTest
@testable import TVShowListingFeatureDomain

// Utils
import TVShowListingFeatureTesting
import NetworkCoreTesting

final class SearchTVShowsUseCaseTests: XCTestCase {
    private var sut: SearchTVShowsUseCase!
    private var repositorySpy: TVShowsRepositorySpy!
    
    override func setUp() {
        super.setUp()
        repositorySpy = TVShowsRepositorySpy()
        sut = SearchTVShowsUseCase(repository: repositorySpy)
    }
    
    override func tearDown() {
        repositorySpy = nil
        sut = nil
        super.tearDown()
    }
    
    func test_execute_onExecute_withValidQuery_shouldReturnResults() async throws {
        // Given
        let mockResults: [TVShowSearchResult] = [
            .init(score: 0.95, show: .init(
                id: 1, name: "Example Show", type: "", language: "", genres: [],
                status: "", averageRuntime: nil, premiered: nil, ended: nil,
                officialSite: nil, schedule: .init(time: "", days: []),
                rating: .init(average: nil), network: nil, webChannel: nil,
                image: nil, summary: nil
            ))
        ]
        repositorySpy.stubbedSearchResults = mockResults
        
        // When
        let results = try await sut.execute(query: "Example")
        
        // Then
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.show.id, 1)
        XCTAssertEqual(repositorySpy.searchCallCount, 1)
        XCTAssertEqual(repositorySpy.receivedQuery, "Example")
    }
    
    func test_execute_onExecute_withRepositoryError_shouldThrowError() async {
        // Given
        let expectedError = URLError(.badURL)
        repositorySpy.errorToThrow = expectedError
        
        // When / Then
        await AsyncAssertions.throwsError(try await self.sut.execute(query: "fail")) { error in
            XCTAssertEqual(error as? URLError, expectedError)
        }
    }
}
