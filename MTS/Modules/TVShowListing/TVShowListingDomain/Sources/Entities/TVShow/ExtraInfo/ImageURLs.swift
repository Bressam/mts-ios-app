//
//  ImageURLs.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation

public struct ImageURLs: Codable {
    public let medium: URL?
    public let original: URL?
    
    public init(medium: URL?, original: URL?) {
        self.medium = medium
        self.original = original
    }
}
