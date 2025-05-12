//
//  TVShowsRepositorySpy.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import TVShowListingFeatureDomain

public final class TVShowsRepositorySpy: TVShowsRepositoryProtocol {
    public private(set) var searchCallCount = 0
    public var receivedQuery: String?
    public var stubbedSearchResults: [TVShowSearchResult] = []
    public var stubbedGetResults: [TVShow] = []
    public var errorToThrow: Error?
    
    public init() {}

    public func searchTVShows(query: String) async throws -> [TVShowSearchResult] {
        searchCallCount += 1
        receivedQuery = query
        
        if let error = errorToThrow {
            throw error
        }
        
        return stubbedSearchResults
    }
    
    public func getTVShows() async throws -> [TVShow] {
        if let error = errorToThrow {
            throw error
        }
        
        return stubbedGetResults
    }
}
