//
//  TVShowDetailsRepositorySpy.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import TVShowListingFeatureDomain

public final class TVShowDetailsRepositorySpy: TVShowDetailsRepositoryProtocol {
    public private(set) var receivedID: Int?
    public var tvShowDetailsToReturn: TVShowDetails?
    public var errorToThrow: Error?
    
    public init() {}
    
    public func getTVShowDetails(id: Int) async throws -> TVShowDetails {
        receivedID = id
        
        if let error = errorToThrow {
            throw error
        }
        
        guard let details = tvShowDetailsToReturn else {
            fatalError("tvShowDetailsToReturn must be set or errorToThrow must be thrown")
        }
        
        return details
    }
}
