//
//  RemoteTVShowsRepository.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain
import TVShowListingFeatureTesting
import NetworkCoreInterface

final public class RemoteTVShowsRepository: TVShowsRepositoryProtocol {
    // Dependencies
    let networkClient: NetworkClientProtocol

    // Paging
    private var currentPage = -1
    private let pageSize = 250

    public init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    public func getTVShows() async throws -> [TVShow] {
        let response = try await networkClient.perform(TVShowRequest.listAll(page: currentPage + 1))
        let tvShows = try JSONDecoder().decode([TVShow].self, from: response.data)
        currentPage += 1
        return tvShows
    }
    
    public func searchTVShows(query: String) async throws -> [TVShowSearchResult] {
        let response = try await networkClient.perform(TVShowRequest.search(query: query))
        let tvShows = try JSONDecoder().decode([TVShowSearchResult].self, from: Data(response.data))
        return tvShows
    }
}
