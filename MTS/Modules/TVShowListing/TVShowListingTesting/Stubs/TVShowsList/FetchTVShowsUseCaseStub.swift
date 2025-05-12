//
//  FetchTVShowsUseCaseStub.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain

final public class FetchTVShowsUseCaseStub: FetchTVShowsUseCaseProtocol {
    public init() {}

    public func execute() async throws -> [TVShow] {
        return TVShow.mock
    }
}
