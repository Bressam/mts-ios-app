//
//  TVShowsListingViewModel.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureInterface
import TVShowListingFeatureTesting

extension TVShowsListingViewModel {
    @MainActor
    static var preview: TVShowsListingViewModel {
        return TVShowsListingViewModel(coordinator: TVShowListingCoordinatorStub(),
                                       fetchTVShowUseCase: FetchTVShowsUseCaseStub())
    }
}
