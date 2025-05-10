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
                detailsView(for: show)
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
    
    // MARK: ViewBuilders
    @ViewBuilder
    private func detailsView(for show: TVShowDetails) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                headerImage(show.image?.original)
                titleAndDetails(for: show)
                summaryView(for: show)
                Divider()
                seasonsAndEpisodesSection(for: show)
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func summaryView(for show: TVShowDetails) -> some View {
        if let summary = show.summary {
            Text(summary.stripHTML())
                .font(.body)
        }
    }
    
    @ViewBuilder
    private func titleAndDetails(for show: TVShowDetails) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(show.name)
                .font(.title)
                .fontWeight(.bold)

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
            
            if let rating = show.rating.average {
                Text(String(format: "Rating: %.1f ★", rating))
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .opacity(0.8)
            }
        }
    }
    
    @ViewBuilder
    private func seasonsAndEpisodesSection(for show: TVShowDetails) -> some View {
        if let seasons = show.embeddedDetails?.seasons {
            Text("Seasons")
                .font(.title)
                .fontWeight(.bold)
            
            seasonPicker(seasons: seasons)
        }

        if let episodesBySeason = viewModel.groupedEpisodes,
           let episodes = episodesBySeason[selectedSeason] {
            Text("Episodes - Season \(selectedSeason)")
                .font(.headline)
            
            ForEach(episodes) { episode in
                episodeRow(for: episode)
                    .padding(.vertical, 6)
                    .onTapGesture {
                        viewModel.didSelectEpisode(episode)
                    }
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
                    Text(summary.stripHTML())
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
        }
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
}

#Preview {
    NavigationStack {
        TVShowDetailView(viewModel: .preview)
    }
}
