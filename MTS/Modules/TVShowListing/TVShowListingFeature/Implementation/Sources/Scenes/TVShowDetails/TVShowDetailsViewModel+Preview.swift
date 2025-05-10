//
//  TVShowDetailsViewModel+Preview.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureInterface
import TVShowListingFeatureTesting

extension TVShowDetailsViewModel {
    @MainActor
    static var preview: TVShowDetailsViewModel {
        return TVShowDetailsViewModel(coordinator: TVShowListingCoordinatorStub(),
                                      fetchTVShowDetailsUseCase: FetchTVShowDetailsUseCaseStub(),
                                      showID: 1)
    }
}
