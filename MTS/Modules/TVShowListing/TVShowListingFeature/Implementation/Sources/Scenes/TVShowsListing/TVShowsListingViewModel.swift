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
    private var searchTVShowUseCase: SearchTVShowsUseCaseProtocol
    
    // Fetch
    @Published var isInitialLoading: Bool = true
    @Published var isLoadingNextPage: Bool = false
    private var hasMorePages = true

    
    // Search
    @Published var searchText: String = ""
    @Published var filteredResults: [TVShow] = []
    @Published var isSearchingRemotely: Bool = false
    private var allLocalShows: [TVShow] = []
    private var debounceTask: Task<(), any Error>?

    init(coordinator: TVShowListingCoordinatorProtocol,
         fetchTVShowUseCase: FetchTVShowsUseCaseProtocol,
         searchTVShowUseCase: SearchTVShowsUseCaseProtocol) {
        self.coordinator = coordinator
        self.fetchTVShowUseCase = fetchTVShowUseCase
        self.searchTVShowUseCase = searchTVShowUseCase
    }
    
    // MARK: - Navigation
    func selectTVShow(with id: Int) {
        guard let selectedShow = allLocalShows.first(where: { $0.id == id }) else {
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
                setLocalShows(newShows)
            }
        } catch {
            hasMorePages = false
            print("Paging error or end of pages: \(error)")
        }
        isLoadingNextPage = false
    }
    
    func isEndOfList(at index: Int) -> Bool {
        return allLocalShows.count - 1 == index
    }
    
    // Initial fetch
    func fetchTVShows() async {
        guard allLocalShows.isEmpty else {
            return
        }

        do {
            let newShows = try await fetchTVShowUseCase.execute()
            await MainActor.run {
                setLocalShows(newShows)
            }
        } catch {
            print("Paging error or end of pages: \(error)")
        }
        isInitialLoading = false
    }
    
    @MainActor
    private func setLocalShows(_ shows: [TVShow]) {
        allLocalShows = shows
        filteredResults = shows
    }

    // MARK: - TVShows search
    private func searchLocaly(for query: String) -> [TVShow] {
        let localMatches = allLocalShows.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
        print("Local matches count: \(localMatches.count)")
        return localMatches
    }
    
    private func searchRemotely(for query: String) async {
        print("No local matches, sarching remotely...")
        await MainActor.run { isSearchingRemotely = true }
        do {
            let remoteSearchResult = try await searchTVShowUseCase.execute(query: query)
            let remoteSearchTVShows = remoteSearchResult.map(\.show)
            print("Remote search result: \(remoteSearchResult.count)")
            await MainActor.run {
                filteredResults = remoteSearchTVShows
                isSearchingRemotely = false
            }
        } catch {
            print("Remote search error: \(error)")
        }
    }
    
    func handleSearchTextChanged() {
        debounceTask?.cancel()
        
        debounceTask = Task {
            // Debounce 300ms
            try await Task.sleep(nanoseconds: 300_000_000)
            let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            
            guard !trimmedQuery.isEmpty else {
                await MainActor.run {
                    filteredResults = allLocalShows
                    isSearchingRemotely = false
                }
                return
            }
            
            let localMatches = searchLocaly(for: trimmedQuery)
            if !localMatches.isEmpty {
                await MainActor.run {
                    filteredResults = localMatches
                    isSearchingRemotely = false
                }
            } else {
                await searchRemotely(for: trimmedQuery)
            }
        }
    }
}
