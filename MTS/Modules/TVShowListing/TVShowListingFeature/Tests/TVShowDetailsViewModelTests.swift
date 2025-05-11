//
//  TVShowDetailsViewModelTests.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import XCTest
import TVShowListingFeatureDomain
@testable import TVShowListingFeature

// Utils
import TVShowListingFeatureTesting

@MainActor
final class TVShowDetailsViewModelTests: XCTestCase {
    private var sut: TVShowDetailsViewModel!
    private var coordinatorSpy: TVShowListingCoordinatorSpy!
    private var detailsUseCaseSpy: FetchTVShowDetailsUseCaseProtocol!
    
    override func setUp() async throws {
        try await super.setUp()
        coordinatorSpy = TVShowListingCoordinatorSpy()
        detailsUseCaseSpy = FetchTVShowDetailsUseCaseSpy()
        
        sut = TVShowDetailsViewModel(
            coordinator: coordinatorSpy,
            fetchTVShowDetailsUseCase: detailsUseCaseSpy,
            currentShowID: 1,
            currentShowTitle: "Test Show"
        )
    }
    
    override func tearDown() {
        coordinatorSpy = nil
        detailsUseCaseSpy = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_fetchTVShows_shouldLoadDetailsSuccessfully() async throws {
        // Given
        let expectedDetails = TVShowDetails.stub(
            id: 1,
            name: "Test Show",
            embeddedDetails: TVShowEmbenddedDetails(episodes: [
                .stub(id: 1, name: "Episode 1"),
                .stub(id: 21, name: "Episode 2"),
            ], seasons: [])
        )
        let spy = detailsUseCaseSpy as! FetchTVShowDetailsUseCaseSpy
        spy.tvShowDetailsToReturn = expectedDetails
        
        // When
        await sut.fetchTVShows()
        
        // Then
        XCTAssertEqual(sut.tvShowDetails?.id, 1)
        XCTAssertEqual(sut.tvShowDetails?.name, "Test Show")
        XCTAssertEqual(sut.groupedEpisodes?.count, 1)
        XCTAssertEqual(sut.groupedEpisodes?[1]?.count, 2)
    }
    
    func test_fetchTVShows_withFailure_shouldNotCrash() async throws {
        // Given
        let spy = detailsUseCaseSpy as! FetchTVShowDetailsUseCaseSpy
        spy.errorToThrow = NSError(domain: "Network", code: -1)
        
        // When
        await sut.fetchTVShows()
        
        // Then
        XCTAssertNil(sut.tvShowDetails)
    }
    
    func test_groupedEpisodes_shouldGroupEpisodesBySeason() {
        // Given
        let mockDetails = TVShowDetails.stub(
            id: 1,
            name: "Test Show",
            embeddedDetails: TVShowEmbenddedDetails(episodes: [
                .stub(id: 1, season: 1, name: "Episode 1"),
                .stub(id: 2, season: 1, name: "Episode 2"),
                .stub(id: 3, season: 2, name: "Episode 3")
            ], seasons: [])
        )
        sut.tvShowDetails = mockDetails
        
        // When
        let grouped = sut.groupedEpisodes
        
        // Then
        XCTAssertEqual(grouped?.count, 2)
        XCTAssertEqual(grouped?[1]?.count, 2)
        XCTAssertEqual(grouped?[2]?.count, 1)
    }
    
    func test_didSelectEpisode_shouldTriggerNavigation() {
        // Given
        let episode = TVShowEpisode.stub(id: 42, season: 1, name: "Test Episode")
        
        // When
        sut.didSelectEpisode(episode)
        
        // Then
        XCTAssertEqual(coordinatorSpy.navigateToEpisodeDetailsCallCount, 1)
        XCTAssertEqual(coordinatorSpy.receivedEpisode?.id, 42)
    }
}
