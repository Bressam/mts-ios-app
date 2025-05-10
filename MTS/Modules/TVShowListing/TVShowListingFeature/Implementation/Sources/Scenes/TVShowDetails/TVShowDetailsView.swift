//
//  TVShowDetailsView.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import SwiftUI
import TVShowListingFeatureDomain

struct TVShowDetailView: View {
    let show: TVShowDetails
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = show.image?.original {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 60, height: 90)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 440)
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
                Text(show.name)
                    .font(.title)
                    .bold()
                
                if !show.genres.isEmpty {
                    Text("Genres: \(show.genres.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let summary = show.summary {
                    Text(stripHTML(summary))
                        .font(.body)
                }
                
                Divider()
                
                if let seasons = show.embeddedDetails?.seasons {
                    Text("Seasons")
                        .font(.headline)
                    ForEach(seasons) { season in
                        Text("Season \(season.number) • Premiered: \(season.premiereDate ?? "Unknown")")
                            .font(.subheadline)
                    }
                }
                
                Divider()
                
                if let episodes = show.embeddedDetails?.episodes {
                    Text("Episodes")
                        .font(.headline)
                    ForEach(episodes) { episode in
                        Text("S\(episode.season)E\(episode.number): \(episode.name)")
                            .font(.subheadline)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Show Details")
    }
    
    // Helper to strip <p>, <b>, etc. for readability
    private func stripHTML(_ html: String) -> String {
        html.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}

#Preview {
    TVShowDetailView(show: .mock)
}
