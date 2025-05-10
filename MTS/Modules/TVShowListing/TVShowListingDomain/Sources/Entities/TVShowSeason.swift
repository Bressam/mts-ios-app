//
//  TVShowSeason.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct TVShowSeason: Decodable  {
    let number: Int
    let episodes: [TVShowEpisode]
    
    public init(number: Int, episodes: [TVShowEpisode]) {
        self.number = number
        self.episodes = episodes
    }
}
