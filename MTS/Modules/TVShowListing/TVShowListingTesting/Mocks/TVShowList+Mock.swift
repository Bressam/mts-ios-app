//
//  TVShow+Mock.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain

extension TVShow {
    public static let mock: [TVShow] = {
        return mockFromJSON()
    }()
    
    private static func mockFromJSON() -> [TVShow] {
        guard let resourceBundle = Bundle(identifier: "dev.bressam.TVShowListingFeatureTesting"),
              let fileURL = resourceBundle.url(forResource: "shows-response", withExtension: "json") else {
            print("Could not find shows.json")
            return []
            }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let shows = try decoder.decode([TVShow].self, from: data)
            return shows
        } catch {
            print("Failed to decode shows: \(error)")
            return []
        }
    }
}
