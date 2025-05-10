//
//  TVShowEpisode.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct TVShowEpisode: Decodable, Identifiable {
    public let id: Int
    public let url: String
    public let name: String
    public let season: Int
    public let number: Int
    public let type: String
    public let airdate: String?
    public let airtime: String?
    public let airstamp: String?
    public let runtime: Int?
    public let rating: Rating
    public let image: ImageURLs?
    public let summary: String?
    
    public init(id: Int, url: String, name: String, season: Int, number: Int, type: String, airdate: String?, airtime: String?, airstamp: String?, runtime: Int?, rating: Rating, image: ImageURLs?, summary: String?) {
        self.id = id
        self.url = url
        self.name = name
        self.season = season
        self.number = number
        self.type = type
        self.airdate = airdate
        self.airtime = airtime
        self.airstamp = airstamp
        self.runtime = runtime
        self.rating = rating
        self.image = image
        self.summary = summary
    }
    
}

