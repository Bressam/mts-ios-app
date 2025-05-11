//
//  Rating.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct Rating: Codable {
    public let average: Double?
    
    public init(average: Double?) {
        self.average = average
    }
}
