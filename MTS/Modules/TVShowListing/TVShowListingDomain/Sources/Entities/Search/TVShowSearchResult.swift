//
//  TVShowSearchResult.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation

public struct TVShowSearchResult: Decodable {
    public let score: Double
    public let show: TVShow
}
