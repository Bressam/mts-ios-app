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
                    url: viewModel.episode.image?.original,
                    width: .infinity,
                    height: 220,
                    cornerRadius: 12
                )
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Season \(viewModel.episode.season), Episode \(viewModel.episode.number)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let summary = viewModel.episode.summary {
                    Text(stripHTML(summary))
                        .font(.body)
                        .padding(.top)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(viewModel.episode.name)
    }
        
    // MARK: - Utils
    private func stripHTML(_ html: String) -> String {
        html.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}

#Preview {
    NavigationStack {
        TVShowEpisodeDetailsView(viewModel: .preview)
    }
}
