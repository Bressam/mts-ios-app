//
//  TVShowsListingView.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import SwiftUI
import TVShowListingFeatureDomain

struct TVShowsListingView: View {
    // MARK: - Properties
    @ObservedObject private var viewModel: TVShowsListingViewModel

    init(viewModel: TVShowsListingViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            if viewModel.isInitialLoading {
                ProgressView("Loading Shows...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                tvShowList
            }
        }
        .overlay {
            if viewModel.filteredResults.isEmpty,
               !viewModel.searchText.isEmpty {
                ContentUnavailableView.search
            }
            
            if viewModel.fetchingError {
                ContentUnavailableView {
                    Label("Something went wrong...", systemImage: "wifi.slash")
                } description: {
                    Text("Please check your connection and try again.")
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchTVShows()
            }
        }
        .navigationTitle("TVMaze Shows")
    }
    
    // MARK: - Views
    // TODO: Error handling
    private var tvShowList: some View {
        List(viewModel.filteredResults) { show in
            TVShowRowView(show: show)
                .padding(.vertical, 8)
                .id(show.id)
                .onTapGesture {
                    viewModel.selectTVShow(with: show.id)
                }
                .onAppear {
                    // Paging
                    if viewModel.isEndOfList(at: show.id) {
                        Task {
                            await viewModel.loadNextPageIfNeeded()
                        }
                    }
                }
        }
        .refreshable {
            Task {
                await viewModel.fetchTVShows()
            }
        }
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText, initial: false, { _, _ in
            viewModel.handleSearchTextChanged()
        })
    }
    
    @ViewBuilder
    private func pagingLoadView(_ show: TVShow) -> some View {
        // Bottom spinner
        if viewModel.isLoadingNextPage,
           viewModel.isEndOfList(at: show.id) {
            HStack {
                Spacer()
                ProgressView()
                    .padding()
                Spacer()
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    NavigationStack {
        TVShowsListingView(viewModel: .preview)
    }
}
