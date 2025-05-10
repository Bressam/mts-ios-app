//
//  TVShowsRepositoryProtocol.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public protocol TVShowsRepositoryProtocol {
    func getTVShows() async throws -> [TVShow]
}
