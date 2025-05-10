//
//  TVShowsListingViewModel.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureInterface
import TVShowListingFeatureDomain


final class TVShowsListingViewModel: ObservableObject {
    @Published var tvShows: [TVShow] = []
    private weak var coordinator: TVShowListingCoordinatorProtocol?
    private var fetchTVShowUseCase: FetchTVShowsUseCaseProtocol
    
    init(coordinator: TVShowListingCoordinatorProtocol,
         fetchTVShowUseCase: FetchTVShowsUseCaseProtocol) {
        self.coordinator = coordinator
        self.fetchTVShowUseCase = fetchTVShowUseCase
    }
    
    func fetchTVShows() async {
        // TODO: Impl
        tvShows = (try? await fetchTVShowUseCase.execute()) ?? []
    }
}
