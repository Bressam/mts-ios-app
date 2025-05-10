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
        navigationController.navigationBar.prefersLargeTitles = true
    }

    public func start() {
        navigateToTVShowsListingView()
    }
    
    public func navigateToTVShowsListingView() {
        let fetchTVShowUsecase = FetchTVShowsUseCase(tvShowRepository: LocalTVShowsRepository())
        let tvShowListingViewModel: TVShowsListingViewModel = .init(coordinator: self,
                                                                    fetchTVShowUseCase: fetchTVShowUsecase)
        let hostingVC = UIHostingController(rootView: TVShowsListingView(viewModel: tvShowListingViewModel))
        hostingVC.navigationItem.backButtonTitle = "TV Shows"
        navigationController.pushViewController(hostingVC, animated: true)
    }
    
    public func navigateToTVShowDetailsView(showID: Int, showTitle: String) {
        let fetchTVShowDetailsUsecase = FetchTVShowDetailsUseCase(tvShowDetailsRepository: LocalTVShowDetailsRepository())
        let tvShowDetailsViewModel = TVShowDetailsViewModel(coordinator: self,
                                                            fetchTVShowDetailsUseCase: fetchTVShowDetailsUsecase,
                                                            currentShowID: showID,
                                                            currentShowTitle: showTitle)
        
        let hostingVC = UIHostingController(rootView: TVShowDetailView(viewModel: tvShowDetailsViewModel))
        navigationController.pushViewController(hostingVC, animated: true)
    }
    
}
