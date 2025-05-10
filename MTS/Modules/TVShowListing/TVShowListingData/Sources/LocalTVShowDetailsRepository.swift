//
//  LocalTVShowDetailsRepository.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain
import TVShowListingFeatureTesting

public final class LocalTVShowDetailsRepository: TVShowDetailsRepositoryProtocol {
    public init() {}

    public func getTVShowDetails(id: Int) async throws -> TVShowListingFeatureDomain.TVShowDetails {
        return .mock // TODO: Temp
    }
}
