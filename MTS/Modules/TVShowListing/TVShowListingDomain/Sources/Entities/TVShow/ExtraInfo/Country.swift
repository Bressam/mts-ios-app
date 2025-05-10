//
//  Country.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

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
