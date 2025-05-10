//
//  TVShowListingAssembly.swift
//  MTS
//
//  Created by Giovanne Bressam on 10/05/25.
//

import Foundation
import NetworkCoreInterface
import TVShowListingFeatureInterface
import TVShowListingFeature

class TVShowListingAssembly {
    @MainActor
    static func assemble(networkClient: NetworkClientProtocol) -> TVShowListingCoordinatorProtocol {
        return TVShowListingCoordinator(navigationController: .init(),
                                        networkClient: networkClient)
    }
}
