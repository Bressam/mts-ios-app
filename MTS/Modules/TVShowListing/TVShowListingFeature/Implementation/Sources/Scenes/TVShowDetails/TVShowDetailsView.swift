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
    // MARK: - Properties
    @ObservedObject private var viewModel: TVShowDetailsViewModel
    @State private var selectedSeason: Int = 1

    init(viewModel: TVShowDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            if let show = viewModel.tvShowDetails {
                detailsView(show: show)
            } else {
                ProgressView()
                    .frame(width: 60, height: 90)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchTVShows()
            }
        }
        .navigationTitle(viewModel.currentShowTitle)
    }
    
    @ViewBuilder
    private func detailsView(show: TVShowDetails) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                headerImage(show.image?.original)
                
                Text(show.name)
                    .font(.title)
                    .bold()
                
                if !show.genres.isEmpty {
                    Text("Genres: \(show.genres.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if !show.schedule.days.isEmpty || !show.schedule.time.isEmpty {
                    Text("Airs: \(show.schedule.days.joined(separator: ", ")) at \(show.schedule.time)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let summary = show.summary {
                    Text(stripHTML(summary))
                        .font(.body)
                }
                
                Divider()
                
                seasonsAndEpisodesSection(show: show)
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func seasonsAndEpisodesSection(show: TVShowDetails) -> some View {
        
        if let seasons = show.embeddedDetails?.seasons {
            Text("Seasons")
                .font(.headline)
            
            seasonPicker(seasons: seasons)
        }
        
        Divider()
        
        if let episodesBySeason = viewModel.groupedEpisodes, let episodes = episodesBySeason[selectedSeason] {
            Text("Episodes - Season \(selectedSeason)")
                .font(.headline)
            
            ForEach(episodes) { episode in
                episodeRow(for: episode)
            }
        }
    }
    
    @ViewBuilder
    private func episodeRow(for episode: TVShowEpisode) -> some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImageView(
                url: episode.image?.medium,
                width: 100,
                height: 60,
                cornerRadius: 8
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("S\(episode.season)E\(episode.number): \(episode.name)")
                    .font(.subheadline)
                    .fontWeight(.medium)

                
                if let summary = episode.summary, !summary.isEmpty {
                    Text(stripHTML(summary))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 6)
    }
    
    @ViewBuilder
    private func headerImage(_ url: URL?) -> some View {
        AsyncImageView(url: url,
                       width: .infinity,
                       height: 220,
                       cornerRadius: 8)
    }
    
    @ViewBuilder
    private func seasonPicker(seasons: [TVShowSeason]) -> some View {
        let seasonNumbers = seasons.map(\.number)
        Picker("Season", selection: $selectedSeason) {
            ForEach(seasonNumbers, id: \.self) { number in
                Text("Season \(number)")
                    .tag(number)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    // MARK: - Utils
    // Helper to strip <p>, <b>, etc. for readability
    private func stripHTML(_ html: String) -> String {
        html.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}

#Preview {
    NavigationStack {
        TVShowDetailView(viewModel: .preview)
    }
}
