//
//  Network.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct Network: Codable {
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
