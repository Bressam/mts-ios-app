//
//  TVShowsListingView.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import SwiftUI

struct TVShowsListingView: View {
    // MARK: - Properties
    @ObservedObject private var viewModel: TVShowsListingViewModel

    init(viewModel: TVShowsListingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.tvShows) { show in
            HStack(alignment: .top, spacing: 16) {
                if let imageUrl = show.image?.medium, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 60, height: 90)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 90)
                                .clipped()
                                .cornerRadius(8)
                        case .failure:
                            Image(systemName: "photo")
                                .frame(width: 60, height: 90)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .frame(width: 60, height: 90)
                }
                
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
            .padding(.vertical, 8)
        }
        .onAppear {
            Task {
                await viewModel.fetchTVShows()
            }
        }
    }
}

#Preview {
    TVShowsListingView(viewModel: .preview)
}
