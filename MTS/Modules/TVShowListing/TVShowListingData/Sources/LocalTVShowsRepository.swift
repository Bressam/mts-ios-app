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
        // TODO: Implement localDB in future
        return TVShow.mock
    }
    
    public func searchTVShows(query: String) async throws -> [TVShowListingFeatureDomain.TVShowSearchResult] {
        // TODO: Implement localDB in future
        return []
    }
}
