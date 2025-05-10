//
//  TVShowListingCoordinatorProtocol.swift
//  TVShowListing
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import CoordinatorKitInterface

public protocol TVShowListingCoordinatorProtocol: CoordinatorProtocol {
    func navigateToTVShowsListingView()
    func navigateToTVShowDetailsView(showID: Int, showTitle: String)
}
