//
//  TVShowEpisode.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct TVShowEpisode: Decodable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let airdate: String?
    let airtime: String?
    let summary: String?
    let image: ImageLinks?
    
    public init(id: Int, name: String, season: Int, number: Int, airdate: String?, airtime: String?, summary: String?, image: ImageLinks?) {
        self.id = id
        self.name = name
        self.season = season
        self.number = number
        self.airdate = airdate
        self.airtime = airtime
        self.summary = summary
        self.image = image
    }
}

