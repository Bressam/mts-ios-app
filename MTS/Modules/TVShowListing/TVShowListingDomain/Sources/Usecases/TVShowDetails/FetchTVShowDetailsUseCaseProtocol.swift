//
//  FetchTVShowsUseCaseProtocol.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation

public protocol FetchTVShowsUseCaseProtocol {
    func execute() async throws -> [TVShow]
}
