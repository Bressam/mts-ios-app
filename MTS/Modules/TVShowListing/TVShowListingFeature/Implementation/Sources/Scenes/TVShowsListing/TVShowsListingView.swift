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
    @State private var searchText: String = ""

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
                List(filteredShows.indices, id: \.self) { index in
                    let show = viewModel.tvShows[index]
                    tvShowRow(show: show)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            viewModel.selectTVShow(with: show.id)
                        }
                        .onAppear {
                            // Check pagination
                            if index == viewModel.tvShows.count - 1 {
                                Task {
                                    await viewModel.loadNextPageIfNeeded()
                                }
                            }
                        }
                }
                .searchable(text: $searchText, prompt: "Search TV Shows")
                
                // Bottom spinner
                if viewModel.isLoadingNextPage {
                    HStack {
                        Spacer()
                        ProgressView()
                            .padding()
                        Spacer()
                    }
                }
            }
        }
        .overlay {
            if filteredShows.isEmpty && !searchText.isEmpty {
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
    
    // MARK: - Utils
    private var filteredShows: [TVShow] {
        if searchText.isEmpty {
            return viewModel.tvShows
        } else {
            return viewModel.tvShows.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TVShowsListingView(viewModel: .preview)
    }
}
