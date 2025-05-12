//
//  TVShowList+Stub.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureDomain

extension TVShow {
    public static func stub(
        id: Int = 1,
        name: String = "Breaking Bad"
    ) -> TVShow {
        TVShow(id: id,
               name: name,
               type: "",
               language: "",
               genres: [],
               status: "",
               averageRuntime: nil,
               premiered: nil,
               ended: nil,
               officialSite: nil,
               schedule: Schedule(time: "", days: []),
               rating: Rating(average: 0),
               network: nil,
               webChannel: nil,
               image: nil,
               summary: nil)
    }
}
