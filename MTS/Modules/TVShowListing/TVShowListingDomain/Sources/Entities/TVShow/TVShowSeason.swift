//
//  TVShowSeason.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct TVShowSeason: Codable, Identifiable {
    public let id: Int
    public let url: String
    public let number: Int
    public let name: String
    public let episodeOrder: Int?
    public let premiereDate: String?
    public let endDate: String?
    public let network: Network?
    public let webChannel: WebChannel?
    public let image: ImageURLs?
    public let summary: String?
    
    public init(id: Int, url: String, number: Int, name: String, episodeOrder: Int?, premiereDate: String?, endDate: String?, network: Network?, webChannel: WebChannel?, image: ImageURLs?, summary: String?) {
        self.id = id
        self.url = url
        self.number = number
        self.name = name
        self.episodeOrder = episodeOrder
        self.premiereDate = premiereDate
        self.endDate = endDate
        self.network = network
        self.webChannel = webChannel
        self.image = image
        self.summary = summary
    }
}
