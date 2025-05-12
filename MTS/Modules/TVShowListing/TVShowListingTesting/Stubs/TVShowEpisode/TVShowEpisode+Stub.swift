//
//  TVShowEpisode+Stub.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import TVShowListingFeatureDomain

public extension TVShowEpisode {
    static func stub(
        id: Int = 1,
        season: Int = 1,
        name: String = "Sample Episode"
    ) -> TVShowEpisode {
        TVShowEpisode(
            id: id,
            url: "https://example.com/episode/\(id)",
            name: name,
            season: season,
            number: 1,
            type: "Regular",
            airdate: "2023-01-01",
            airtime: "20:00",
            airstamp: "2023-01-01T20:00:00Z",
            runtime: 45,
            rating: Rating(average: 8.5),
            image: ImageURLs(medium: URL(string: "https://www.anyURL.com")!,
                             original: URL(string: "https://www.anyURL.com")!),
            summary: "This is a stub episode for testing purposes."
        )
    }
}
