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
    public let image: ImageLinks?
    public let summary: String?
    
    public init(id: Int, name: String, type: String, language: String, genres: [String], status: String, averageRuntime: Int?, premiered: String?, ended: String?, officialSite: String?, schedule: Schedule, rating: Rating, network: Network?, webChannel: WebChannel?, image: ImageLinks?, summary: String?) {
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


public struct Rating: Decodable {
    public let average: Double?
    
    public init(average: Double?) {
        self.average = average
    }
}

public struct Network: Decodable {
    public let id: Int
    public let name: String
    public let country: Country
    public let officialSite: String?
    
    public init(id: Int, name: String, country: Country, officialSite: String?) {
        self.id = id
        self.name = name
        self.country = country
        self.officialSite = officialSite
    }
}

public struct WebChannel: Decodable {
    public let id: Int
    public let name: String
    public let country: Country?
    public let officialSite: String?
    
    public init(id: Int, name: String, country: Country?, officialSite: String?) {
        self.id = id
        self.name = name
        self.country = country
        self.officialSite = officialSite
    }
}

public struct Country: Decodable {
    public let name: String
    public let code: String
    public let timezone: String
    
    public init(name: String, code: String, timezone: String) {
        self.name = name
        self.code = code
        self.timezone = timezone
    }
}

public struct Schedule: Decodable {
    public let time: String
    public let days: [String]
    
    public init(time: String, days: [String]) {
        self.time = time
        self.days = days
    }
}

public struct ImageLinks: Decodable {
    public let medium: String?
    public let original: String?
    
    public init(medium: String?, original: String?) {
        self.medium = medium
        self.original = original
    }
}
