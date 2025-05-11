//
//  SearchTVShowsUseCaseProtocol.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation

public protocol SearchTVShowsUseCaseProtocol {
    func execute(query: String) async throws -> [TVShowSearchResult]
}
