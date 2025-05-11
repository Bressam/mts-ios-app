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
        }
        .onAppear {
            Task {
                await viewModel.fetchTVShows()
            }
        }
        .navigationTitle("TVMaze Shows")
    }
    
    // MARK: - Views
    // TODO: Improvements: LazyVStack & Stay at index after loading
    // TODO: Error handling
    private var tvShowList: some View {
        VStack {
            List {
                ForEach(viewModel.filteredResults, id: \.self) { show in
                    tvShowRow(show: show)
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
            }

            pagingLoadView
        }
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText, initial: false, { _, _ in
            viewModel.handleSearchTextChanged()
        })
    }
    
    @ViewBuilder
    private var pagingLoadView: some View {
        // Bottom spinner
        if viewModel.isLoadingNextPage {
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
    
    @ViewBuilder
    private func tvShowRow(show: TVShow) -> some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImageView(url: show.image?.medium)
                .frame(width: 60, height: 90)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(show.name)
                    .font(.headline)
                
                Text(show.genres.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Status: \(show.status)")
                    .font(.caption)
                    .foregroundColor(.gray)

                if let rating = show.rating.average {
                    Text(String(format: "Rating: %.1f ★", rating))
                        .font(.caption)
                        .foregroundColor(.orange)
                        .opacity(0.8)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TVShowsListingView(viewModel: .preview)
    }
}
