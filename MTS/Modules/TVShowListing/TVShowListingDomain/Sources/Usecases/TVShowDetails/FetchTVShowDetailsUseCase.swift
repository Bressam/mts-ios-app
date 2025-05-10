//
//  FetchTVShowDetailsUseCase.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

final public class FetchTVShowDetailsUseCase: FetchTVShowDetailsUseCaseProtocol {
    private let tvShowDetailsRepository: TVShowDetailsRepositoryProtocol
    
    public init(tvShowDetailsRepository: TVShowDetailsRepositoryProtocol) {
        self.tvShowDetailsRepository = tvShowDetailsRepository
    }

    public func execute(showID: Int) async throws -> TVShowDetails {
        return try await tvShowDetailsRepository.getTVShowDetails(id: showID)
    }
}

