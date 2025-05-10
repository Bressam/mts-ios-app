//
//  TVShowListingAssembly.swift
//  MTS
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import TVShowListingFeatureInterface
import TVShowListingFeature

class TVShowListingAssembly {
    @MainActor
    static func assemble() -> TVShowListingCoordinatorProtocol {
        return TVShowListingCoordinator(navigationController: .init())
    }
}
