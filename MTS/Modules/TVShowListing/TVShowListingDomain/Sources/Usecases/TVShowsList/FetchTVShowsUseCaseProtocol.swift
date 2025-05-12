//
//  FetchTVShowDetailsUseCaseProtocol.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation

public protocol FetchTVShowDetailsUseCaseProtocol {
    func execute(showID: Int) async throws -> TVShowDetails
}
