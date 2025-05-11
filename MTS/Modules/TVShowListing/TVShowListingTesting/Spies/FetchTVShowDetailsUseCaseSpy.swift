//
//  FetchTVShowDetailsUseCaseSpy.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import TVShowListingFeatureDomain

public final class FetchTVShowDetailsUseCaseSpy: FetchTVShowDetailsUseCaseProtocol {
    public var tvShowDetailsToReturn: TVShowDetails?
    public var errorToThrow: Error?

    public init() {}

    public func execute(showID: Int) async throws -> TVShowDetails {
        if let error = errorToThrow {
            throw error
        }
        
        guard let details = tvShowDetailsToReturn else {
            fatalError("tvShowDetailsToReturn must be set or errorToThrow must be thrown")
        }
        
        return details
    }
}
