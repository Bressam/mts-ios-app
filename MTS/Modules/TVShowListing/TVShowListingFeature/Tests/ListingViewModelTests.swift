//
//  SomeTests.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 09/05/25.
//

import XCTest
import TVShowListingFeatureDomain
@testable import TVShowListingFeature

import TVShowListingFeatureTesting

@MainActor
final class TVShowsListingViewModelTests: XCTestCase {
    private var sut: TVShowsListingViewModel!
    private var coordinatorSpy: TVShowListingCoordinatorSpy!
    private var repositorySpy: TVShowsRepositorySpy!
    
    override func setUp() async throws {
        try await super.setUp()
        coordinatorSpy = TVShowListingCoordinatorSpy()
        repositorySpy = TVShowsRepositorySpy()
        
        sut = TVShowsListingViewModel(
            coordinator: coordinatorSpy,
            fetchTVShowUseCase: FetchTVShowsUseCase(tvShowRepository: repositorySpy),
            searchTVShowUseCase: SearchTVShowsUseCase(repository: repositorySpy)
        )
    }
    
    func test_fetchTVShows_shouldLoadInitialShows() async throws {
        // Given
        let expectedShows = [
            TVShow.stub(id: 1, name: "Test Show 1"),
            TVShow.stub(id: 2, name: "Test Show 2")
        ]
        repositorySpy.stubbedGetResults = expectedShows
        
        // When
        await sut.fetchTVShows()
        
        // Then
        XCTAssertFalse(sut.isInitialLoading)
        XCTAssertEqual(sut.filteredResults, expectedShows)
    }
    
    func test_loadNextPageIfNeeded_shouldAppendMoreShows() async throws {
        // Given
        let initialShows = [
            TVShow.stub(id: 1, name: "First")
        ]
        repositorySpy.stubbedGetResults = initialShows
        
        await sut.fetchTVShows()
        
        let moreShows = [
            TVShow.stub(id: 2, name: "Second"),
            TVShow.stub(id: 3, name: "Third")
        ]
        repositorySpy.stubbedGetResults = moreShows
        
        // When
        await sut.loadNextPageIfNeeded()
        
        // Then
        XCTAssertTrue(sut.filteredResults.contains(where: { $0.id == 3 }))
    }
    
    func test_handleSearchTextChanged_shouldSearchLocallyWhenMatchesExist() async throws {
        // Given
        let expectedShow = TVShow.stub(id: 1, name: "Breaking Bad")
        repositorySpy.stubbedGetResults = [expectedShow]
        await sut.fetchTVShows()
        
        // When
        sut.searchText = "breaking"
        
        let expectation = XCTestExpectation(description: "Debounced search completes")
        Task {
            try await Task.sleep(nanoseconds: 500_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        // Then
        XCTAssertEqual(sut.filteredResults.count, 1)
        XCTAssertEqual(sut.filteredResults.first?.name, "Breaking Bad")
    }
    
    func test_handleSearchTextChanged_shouldSearchRemotelyWhenNoLocalMatch() async throws {
        // Given
        repositorySpy.stubbedGetResults = [] // No local results
        await sut.fetchTVShows() // Ensure no local shows
        
        let remoteShow = TVShowSearchResult(score: 0, show: .stub(id: 99, name: "Remote Show"))
        repositorySpy.stubbedSearchResults = [remoteShow]
        
        let expectation = XCTestExpectation(description: "Remote search completes")
        
        // When
        sut.searchText = "Remote"
        sut.handleSearchTextChanged()
        
        Task {
            while sut.filteredResults.isEmpty {
                try await Task.sleep(nanoseconds: 50_000_000) // 50ms polling
            }
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)

        // Then
        XCTAssertEqual(sut.filteredResults.count, 1)
        XCTAssertEqual(sut.filteredResults.first?.id, 99)
    }
    
    func test_selectTVShow_shouldTriggerNavigationWithCorrectID() async throws {
        // Given
        let show = TVShow.stub(id: 10, name: "Peaky Blinders")
        repositorySpy.stubbedGetResults = [show]
        await sut.fetchTVShows()
        
        // When
        sut.selectTVShow(with: 10)
        
        // Then
        XCTAssertEqual(coordinatorSpy.navigateToDetailsCallCount, 1)
        XCTAssertEqual(coordinatorSpy.receivedShowID, 10)
        XCTAssertEqual(coordinatorSpy.receivedShowTitle, "Peaky Blinders")
    }
    
    func test_fetchTVShows_shouldSetFetchingErrorWhenFails() async throws {
        // Given
        repositorySpy.errorToThrow = NSError(domain: "Network", code: -1)
        
        // When
        await sut.fetchTVShows()
        
        // Then
        XCTAssertTrue(sut.fetchingError)
        XCTAssertFalse(sut.isInitialLoading)
    }
}
