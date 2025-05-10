//
//  TVShowsListingViewModel.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureInterface
import TVShowListingFeatureDomain
import NetworkCoreInterface

@MainActor
final class TVShowsListingViewModel: ObservableObject {
    // MARK: - Properties
    private weak var coordinator: TVShowListingCoordinatorProtocol?
    private var fetchTVShowUseCase: FetchTVShowsUseCaseProtocol
    
    @Published var tvShows: [TVShow] = []
    @Published var isInitialLoading: Bool = true
    @Published var isLoadingNextPage: Bool = false
    private var hasMorePages = true

    init(coordinator: TVShowListingCoordinatorProtocol,
         fetchTVShowUseCase: FetchTVShowsUseCaseProtocol) {
        self.coordinator = coordinator
        self.fetchTVShowUseCase = fetchTVShowUseCase
    }
    
    
    // MARK: - Navigation
    func selectTVShow(with id: Int) {
        guard let selectedShow = tvShows.first(where: { $0.id == id }) else {
            print("Mismatching show ID for selected ID: \(id)")
            return
        }
        coordinator?.navigateToTVShowDetailsView(showID: selectedShow.id, showTitle: selectedShow.name)
    }

    // MARK: - TVShows fetch
    // Paging
    func loadNextPageIfNeeded() async {
        guard !isLoadingNextPage, hasMorePages else { return }
        isLoadingNextPage = true
        
        do {
            let newShows = try await fetchTVShowUseCase.execute()
            await MainActor.run {
                tvShows.append(contentsOf: newShows)
            }
        } catch {
            hasMorePages = false
            print("Paging error or end of pages: \(error)")
        }
        isLoadingNextPage = false
    }
    
    // Initial fetch
    func fetchTVShows() async {
        guard tvShows.isEmpty else {
            return
        }

        do {
            let newShows = try await fetchTVShowUseCase.execute()
            await MainActor.run {
                tvShows = newShows
            }
        } catch {
            print("Paging error or end of pages: \(error)")
        }
        isInitialLoading = false
    }
}
