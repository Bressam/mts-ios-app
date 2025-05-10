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

public final class RemoteTVShowsRepository: TVShowsRepositoryProtocol {
    // Dependencies
    let networkClient: NetworkClientProtocol

    // Paging
    private var currentPage = -1
    private let pageSize = 250

    public init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    public func getTVShows() async throws -> [TVShow] {
        currentPage += 1
        
        print("Fetching page: \(currentPage)")
        let response = try await networkClient.perform(TVShowRequest.listAll(page: currentPage))
        let tvShows = try JSONDecoder().decode([TVShow].self, from: response.data)
        return tvShows
    }
}
