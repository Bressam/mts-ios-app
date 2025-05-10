//
//  TVShow+Mock.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain

extension TVShowDetails {
    public static let mock: TVShowDetails = {
        return mockFromJSON()! //Force cast, json for debugging and preview only
    }()
    
    private static func mockFromJSON() -> TVShowDetails? {
        guard let resourceBundle = Bundle(identifier: "dev.bressam.TVShowListingFeatureTesting"),
              let fileURL = resourceBundle.url(forResource: "show-details-response", withExtension: "json") else {
            print("Could not find show-details-response.json")
            return nil
            }

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let showDetails = try decoder.decode(TVShowDetails.self, from: data)
            return showDetails
        } catch {
            print("Failed to decode show details: \(error)")
            return nil
        }
    }
}
