//
//  TVShowSearchResult.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation

public struct TVShowSearchResult: Codable {
    public let score: Double
    public let show: TVShow
    
    public init(score: Double, show: TVShow) {
        self.score = score
        self.show = show
    }
}
