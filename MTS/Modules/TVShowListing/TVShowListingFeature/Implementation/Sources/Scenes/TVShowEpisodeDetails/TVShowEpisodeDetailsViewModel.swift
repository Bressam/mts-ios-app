//
//  TVShowEpisodeDetailsViewModel.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureInterface
import TVShowListingFeatureDomain

final class TVShowEpisodeDetailsViewModel: ObservableObject {
    // MARK: - Properties
    var episode: TVShowEpisode

    // MARK: - Init & Setup
    init(episode: TVShowEpisode) {
        self.episode = episode
    }
}
