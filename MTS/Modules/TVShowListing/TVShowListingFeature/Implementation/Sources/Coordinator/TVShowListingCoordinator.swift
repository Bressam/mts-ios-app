//
//  SomeFeature.swift
//  TVShowListingCoordinator
//
//  Created by Giovanne Bressam on 09/05/25.
//

import Foundation
import UIKit
import SwiftUI
import CoordinatorKitInterface
import TVShowListingFeatureInterface
import TVShowListingFeatureData
import TVShowListingFeatureDomain

final public class TVShowListingCoordinator: TVShowListingCoordinatorProtocol {
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func start() {
        navigateToTVShowsListingView()
    }
    
    private func navigateToTVShowsListingView() {
        let fetchTVShowUsecase = FetchTVShowsUseCase(tvShowRepository: LocalTVShowsRepository())
        let tvShowListingViewModel: TVShowsListingViewModel = .init(coordinator: self,
                                                                    fetchTVShowUseCase: fetchTVShowUsecase)
        let hostingVC = UIHostingController(rootView: TVShowsListingView(viewModel: tvShowListingViewModel))
        navigationController.pushViewController(hostingVC, animated: true)
    }
}
