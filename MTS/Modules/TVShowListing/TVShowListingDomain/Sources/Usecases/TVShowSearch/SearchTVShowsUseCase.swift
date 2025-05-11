//
//  SearchTVShowsUseCase.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation

final public class SearchTVShowsUseCase: SearchTVShowsUseCaseProtocol {
    private let repository: TVShowsRepositoryProtocol
    
    public init(repository: TVShowsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(query: String) async throws -> [TVShowSearchResult] {
        try await repository.searchTVShows(query: query)
    }
}
