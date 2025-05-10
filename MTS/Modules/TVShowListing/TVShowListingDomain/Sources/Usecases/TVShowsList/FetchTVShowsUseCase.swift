//
//  FetchTVShowsUseCase.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

final public class FetchTVShowsUseCase: FetchTVShowsUseCaseProtocol {
    private let tvShowRepository: TVShowsRepositoryProtocol
    
    public init(tvShowRepository: TVShowsRepositoryProtocol) {
        self.tvShowRepository = tvShowRepository
    }

    public func execute() async throws -> [TVShow] {
        return try await tvShowRepository.getTVShows()
    }
}
