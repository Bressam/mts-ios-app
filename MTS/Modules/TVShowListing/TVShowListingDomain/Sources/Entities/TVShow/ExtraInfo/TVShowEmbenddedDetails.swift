//
//  TVShowEmbenddedDetails.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

public struct TVShowEmbenddedDetails: Decodable {
    public let episodes: [TVShowEpisode]
    public let seasons: [TVShowSeason]
    
    public init(episodes: [TVShowEpisode], seasons: [TVShowSeason]) {
        self.episodes = episodes
        self.seasons = seasons
    }
}
