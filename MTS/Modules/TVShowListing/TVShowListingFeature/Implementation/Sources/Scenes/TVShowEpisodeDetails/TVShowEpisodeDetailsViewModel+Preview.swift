//
//  TVShowDetailsViewModel+Preview.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureInterface
import TVShowListingFeatureTesting
import TVShowListingFeatureDomain

extension TVShowEpisodeDetailsViewModel {
    @MainActor
    static var preview: TVShowEpisodeDetailsViewModel {
        let tvShowEpisode = TVShowDetails.mock.embeddedDetails?.episodes.first
        return .init(episode: tvShowEpisode!)
    }
}
