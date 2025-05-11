//
//  Untitled.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import TVShowListingFeatureDomain

public extension TVShowDetails {
    static func stub(
        id: Int = 1,
        name: String = "Breaking Bad",
        embeddedDetails: TVShowEmbenddedDetails? = nil
    ) -> TVShowDetails {
        TVShowDetails(
            id: id,
            name: name,
            type: "Scripted",
            language: "English",
            genres: ["Drama"],
            status: "Ended",
            averageRuntime: 60,
            premiered: "2008-01-20",
            ended: "2013-09-29",
            officialSite: "https://www.amc.com/shows/breaking-bad",
            schedule: Schedule(time: "21:00", days: ["Sunday"]),
            rating: Rating(average: 9.5),
            network: Network(id: 1, name: "AMC", country: Country(name: "USA", code: "US", timezone: "America/New_York"), officialSite: ""),
            webChannel: nil,
            image: ImageURLs(medium: URL(string: "https://www.anyURL.com")!,
                             original: URL(string: "https://www.anyURL.com")!),
            summary: "<p>A high school chemistry teacher turned methamphetamine producer...</p>",
            embeddedDetails: embeddedDetails
        )
    }
}
