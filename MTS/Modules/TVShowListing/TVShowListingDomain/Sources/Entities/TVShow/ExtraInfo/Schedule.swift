//
//  Schedule.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct Schedule: Decodable {
    public let time: String
    public let days: [String]
    
    public init(time: String, days: [String]) {
        self.time = time
        self.days = days
    }
}
