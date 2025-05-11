//
//  FetchTVShowDetailsUseCaseTests.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import XCTest
@testable import TVShowListingFeatureDomain

// Utils
import TVShowListingFeatureTesting
import NetworkCoreTesting

final class FetchTVShowDetailsUseCaseTests: XCTestCase {
    func test_execute_withValidID_shouldReturnTVShowDetails() async throws {
        // Given
        let expectedDetails = TVShowDetails.stub(id: 1, name: "Breaking Bad")
        let repository = TVShowDetailsRepositorySpy()
        repository.tvShowDetailsToReturn = expectedDetails
        let useCase = FetchTVShowDetailsUseCase(tvShowDetailsRepository: repository)
        
        // When
        let result = try await useCase.execute(showID: 1)
        
        // Then
        XCTAssertEqual(result.id, expectedDetails.id)
        XCTAssertEqual(repository.receivedID, 1)
    }
    
    func test_execute_withRepositoryError_shouldThrow() async {
        // Given
        enum AnyError: Error, Equatable { case failure }
        let repository = TVShowDetailsRepositorySpy()
        repository.errorToThrow = AnyError.failure
        let useCase = FetchTVShowDetailsUseCase(tvShowDetailsRepository: repository)
        
        // When & Then
        do {
            _ = try await useCase.execute(showID: 1)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? AnyError, .failure)
        }
    }
}
