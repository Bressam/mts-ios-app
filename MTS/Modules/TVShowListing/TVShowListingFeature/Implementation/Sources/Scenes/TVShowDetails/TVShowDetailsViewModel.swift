//
//  TVShowDetailsView.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureInterface
import TVShowListingFeatureDomain

final class TVShowDetailsViewModel: ObservableObject {
    @Published var tvShowDetails: TVShowDetails?
    private weak var coordinator: TVShowListingCoordinatorProtocol?
    private var fetchTVShowDetailsUseCase: FetchTVShowDetailsUseCaseProtocol
    private let currentShowID: Int
    
    init(coordinator: TVShowListingCoordinatorProtocol,
         fetchTVShowDetailsUseCase: FetchTVShowDetailsUseCaseProtocol,
         showID: Int) {
        self.coordinator = coordinator
        self.fetchTVShowDetailsUseCase = fetchTVShowDetailsUseCase
        self.currentShowID = showID
    }
    
    func fetchTVShows() async {
        let tempTVShowDetails = (try? await fetchTVShowDetailsUseCase.execute(showID: currentShowID))
        await MainActor.run {
            self.tvShowDetails = tempTVShowDetails
        }
    }
}
