//
//  LocalTVShowDetailsRepository.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain
import TVShowListingFeatureTesting

final public class LocalTVShowDetailsRepository: TVShowDetailsRepositoryProtocol {
    public init() {}

    public func getTVShowDetails(id: Int) async throws -> TVShowDetails {
        return .mock // TODO: Temp
    }
}
