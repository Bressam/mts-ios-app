//
//  TVShowDetailsView.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import SwiftUI
import TVShowListingFeatureDomain

struct TVShowEpisodeDetailsView: View {
    // MARK: - Properties
    @ObservedObject private var viewModel: TVShowEpisodeDetailsViewModel
    
    init(viewModel: TVShowEpisodeDetailsViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(
                    url: viewModel.episode.image?.original)
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Season \(viewModel.episode.season), Episode \(viewModel.episode.number)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let summary = viewModel.episode.summary {
                    Text(summary.stripHTML())
                        .font(.body)
                        .padding(.top)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .scrollIndicators(.hidden)
        .navigationTitle(viewModel.episode.name)
    }
}

#Preview {
    NavigationStack {
        TVShowEpisodeDetailsView(viewModel: .preview)
    }
}
