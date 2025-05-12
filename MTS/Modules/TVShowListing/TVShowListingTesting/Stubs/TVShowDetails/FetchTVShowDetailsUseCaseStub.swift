//
//  FetchTVShowDetailsUseCaseStub.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain

final public class FetchTVShowDetailsUseCaseStub: FetchTVShowDetailsUseCaseProtocol {
    public init() {}

    public func execute(showID: Int) async throws -> TVShowDetails {
        return .mock
    }
}
