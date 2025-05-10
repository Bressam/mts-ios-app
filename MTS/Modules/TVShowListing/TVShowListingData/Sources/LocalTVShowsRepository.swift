//
//  LocalTVShowsRepository.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain
import TVShowListingFeatureTesting

public final class LocalTVShowsRepository: TVShowsRepositoryProtocol {
    public init() {}

    public func getTVShows() async throws -> [TVShow] {
        return TVShow.mock // TODO: Temp
    }
}
