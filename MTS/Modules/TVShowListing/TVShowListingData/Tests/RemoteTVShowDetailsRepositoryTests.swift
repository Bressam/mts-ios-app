//
//  RemoteTVShowDetailsRepositoryTests.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import XCTest
import TVShowListingFeatureDomain
import NetworkCoreInterface
@testable import TVShowListingFeatureData

// Test Utils
import TVShowListingFeatureTesting
import NetworkCoreTesting

final class RemoteTVShowDetailsRepositoryTests: XCTestCase {
    private var sut: RemoteTVShowDetailsRepository!
    private var networkClientSpy: NetworkClientSpy!
    
    override func setUp() {
        super.setUp()
        networkClientSpy = NetworkClientSpy(expectedResponse: .ok())
        sut = RemoteTVShowDetailsRepository(networkClient: networkClientSpy)
    }
    
    override func tearDown() {
        networkClientSpy = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - getTVShowDetails
    
    func test_getTVShowDetails_onExecute_withValidResponse_shouldReturnParsedDetails() async throws {
        // Given
        let dummy = TVShowDetails(
            id: 1,
            name: "Mock Show",
            type: "",
            language: "",
            genres: [],
            status: "",
            averageRuntime: nil,
            premiered: nil,
            ended: nil,
            officialSite: nil,
            schedule: .init(time: "", days: []),
            rating: .init(average: nil),
            network: nil,
            webChannel: nil,
            image: nil,
            summary: nil,
            embeddedDetails: nil
        )
        
        networkClientSpy.responseData = try JSONEncoder().encode(dummy)
        
        // When
        let result = try await sut.getTVShowDetails(id: 1)
        
        // Then
        XCTAssertEqual(result.id, dummy.id)
        XCTAssertEqual(networkClientSpy.callCount, 1)
    }
    
    func test_getTVShowDetails_onExecute_withInvalidJSON_shouldThrowDecodingError() async {
        // Given
        networkClientSpy.responseData = Data("bad json".utf8)
        
        // When / Then
        await AsyncAssertions.throwsError(try await self.sut.getTVShowDetails(id: 999)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func test_getTVShowDetails_onExecute_withClientError_shouldThrowSameError() async {
        // Given
        let expectedError = URLError(.timedOut)
        networkClientSpy.errorToThrow = expectedError
        
        // When / Then
        await AsyncAssertions.throwsError(try await self.sut.getTVShowDetails(id: 1)) { error in
            XCTAssertEqual(error as? URLError, expectedError)
        }
    }
}
