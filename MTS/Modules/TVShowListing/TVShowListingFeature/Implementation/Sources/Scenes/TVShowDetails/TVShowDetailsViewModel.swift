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
    // MARK: - Properties
    private weak var coordinator: TVShowListingCoordinatorProtocol?
    private var fetchTVShowDetailsUseCase: FetchTVShowDetailsUseCaseProtocol
    
    @Published var tvShowDetails: TVShowDetails?
    let currentShowID: Int
    let currentShowTitle: String
    var groupedEpisodes: [Int: [TVShowEpisode]]? {
        guard let episodes = tvShowDetails?.embeddedDetails?.episodes else { return nil }
        return Dictionary(grouping: episodes, by: \.season)
    }

    // MARK: - Init & Setup
    init(coordinator: TVShowListingCoordinatorProtocol,
         fetchTVShowDetailsUseCase: FetchTVShowDetailsUseCaseProtocol,
         currentShowID: Int,
         currentShowTitle: String) {
        self.coordinator = coordinator
        self.fetchTVShowDetailsUseCase = fetchTVShowDetailsUseCase
        self.currentShowID = currentShowID
        self.currentShowTitle = currentShowTitle
    }
    
    // MARK: - Methods
    func fetchTVShows() async {
        do {
            let tempTVShowDetails = try await fetchTVShowDetailsUseCase.execute(showID: currentShowID)
            await MainActor.run {
                self.tvShowDetails = tempTVShowDetails
            }
        } catch {
            print("Loading TVShow detail error: \(error)")
        }
    }
    
    func didSelectEpisode(_ episode: TVShowEpisode) {
        coordinator?.navigateToEpisodeDetails(episode: episode)
    }
}
