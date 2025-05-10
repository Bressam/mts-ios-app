//
//  TVShowDetails.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct TVShowDetails: Decodable, Identifiable {
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
    public let embeddedDetails: TVShowEmbenddedDetails?
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, language, genres, status, averageRuntime, premiered, ended, officialSite, schedule, rating, network, webChannel, image, summary
        case embeddedDetails = "_embedded"
    }
}
