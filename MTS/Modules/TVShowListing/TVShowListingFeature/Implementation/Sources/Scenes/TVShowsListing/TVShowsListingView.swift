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
        List(viewModel.tvShows) { show in
            tvShowRow(show: show)
                .padding(.vertical, 8)
                .onTapGesture {
                    viewModel.selectTVShow(with: show.id)
                }
        }
        .onAppear {
            Task {
                await viewModel.fetchTVShows()
            }
        }
        .navigationTitle("TVMaze Shows")
    }
    
    @ViewBuilder
    private func tvShowRow(show: TVShow) -> some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImageView(url: show.image?.medium,
                           width: 60,
                           height: 90,
                           cornerRadius: 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(show.name)
                    .font(.headline)
                
                Text(show.genres.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Status: \(show.status)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TVShowsListingView(viewModel: .preview)
    }
}
