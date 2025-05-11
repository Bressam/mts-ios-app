//
//  TVShowListingCoordinatorSpy.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 11/05/25.
//

import Foundation
import UIKit
import TVShowListingFeatureInterface
import TVShowListingFeatureDomain

public final class TVShowListingCoordinatorSpy: TVShowListingCoordinatorProtocol {
    public var navigationController: UINavigationController = .init()
    
    // MARK: - Tracking Properties
    public private(set) var startCallCount = 0
    public private(set) var navigateToListCallCount = 0
    public private(set) var navigateToDetailsCallCount = 0
    public private(set) var navigateToEpisodeDetailsCallCount = 0
    
    public private(set) var receivedShowID: Int?
    public private(set) var receivedShowTitle: String?
    public private(set) var receivedEpisode: TVShowEpisode?
    
    // MARK: - Optional Closures for Injection
    public var onStart: (() -> Void)?
    public var onNavigateToList: (() -> Void)?
    public var onNavigateToDetails: ((Int, String) -> Void)?
    public var onNavigateToEpisodeDetails: ((TVShowEpisode) -> Void)?
    
    public init() {}
    
    public func start() {
        startCallCount += 1
        onStart?()
    }
    
    public func navigateToTVShowsListingView() {
        navigateToListCallCount += 1
        onNavigateToList?()
    }
    
    public func navigateToTVShowDetailsView(showID: Int, showTitle: String) {
        navigateToDetailsCallCount += 1
        receivedShowID = showID
        receivedShowTitle = showTitle
        onNavigateToDetails?(showID, showTitle)
    }
    
    public func navigateToEpisodeDetails(episode: TVShowEpisode) {
        navigateToEpisodeDetailsCallCount += 1
        receivedEpisode = episode
        onNavigateToEpisodeDetails?(episode)
    }
}
