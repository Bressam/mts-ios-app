//
//  TVShow.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct TVShow: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let type: String
    public let language: String
    public let genres: [String]
    public let status: String
    public let averageRuntime: Int?
    public let premiered: String?
    public let ended: String?
    public let officialSite: String?
    public let schedule: Schedule
    public let rating: Rating
    public let network: Network?
    public let webChannel: WebChannel?
    public let image: ImageURLs?
    public let summary: String?
    
    public init(id: Int, name: String, type: String, language: String, genres: [String], status: String, averageRuntime: Int?, premiered: String?, ended: String?, officialSite: String?, schedule: Schedule, rating: Rating, network: Network?, webChannel: WebChannel?, image: ImageURLs?, summary: String?) {
        self.id = id
        self.name = name
        self.type = type
        self.language = language
        self.genres = genres
        self.status = status
        self.averageRuntime = averageRuntime
        self.premiered = premiered
        self.ended = ended
        self.officialSite = officialSite
        self.schedule = schedule
        self.rating = rating
        self.network = network
        self.webChannel = webChannel
        self.image = image
        self.summary = summary
    }
}

