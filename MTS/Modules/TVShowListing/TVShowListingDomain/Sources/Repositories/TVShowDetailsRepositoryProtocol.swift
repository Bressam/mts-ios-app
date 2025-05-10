//
//  TVShowDetailsRepositoryProtocol.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public protocol TVShowDetailsRepositoryProtocol {
    func getTVShowDetails(id: Int) async throws -> TVShowDetails
}
