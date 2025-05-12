//
//  SearchTVShowUseCaseStub.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import TVShowListingFeatureDomain

final public class SearchTVShowUseCaseStub: SearchTVShowsUseCaseProtocol {
    public init() {}

    public func execute(query: String) async throws -> [TVShowListingFeatureDomain.TVShowSearchResult] {
        return TVShow.mock.map({ TVShowSearchResult(score: 0.0, show: $0) })
    }
}
