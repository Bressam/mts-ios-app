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

extension TVShowDetailsViewModel {
    @MainActor
    static var preview: TVShowDetailsViewModel {
        let tvShowMock = TVShow.mock.first!
        return TVShowDetailsViewModel(coordinator: TVShowListingCoordinatorStub(),
                                      fetchTVShowDetailsUseCase: FetchTVShowDetailsUseCaseStub(),
                                      currentShowID: tvShowMock.id,
                                      currentShowTitle: tvShowMock.name)
    }
}
