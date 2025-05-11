//
//  RemoteTVShowDetailsRepository.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain
import TVShowListingFeatureTesting
import NetworkCoreInterface

final public class RemoteTVShowDetailsRepository: TVShowDetailsRepositoryProtocol {
    // Dependencies
    let networkClient: NetworkClientProtocol

    public init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    public func getTVShowDetails(id: Int) async throws -> TVShowDetails {
        let response = try await networkClient.perform(TVShowRequest.details(id: id))
        let tvShowDetails = try JSONDecoder().decode(TVShowDetails.self, from: response.data)
        return tvShowDetails
    }
}
